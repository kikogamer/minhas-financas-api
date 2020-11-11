# frozen_string_literal: true

require('rails_helper')

RSpec.describe('Users', type: :request) do
  describe 'GET /api/v1/users/current' do
    context 'Invalid User Token' do
      it_behaves_like :deny_without_authorization, :get, '/api/v1/users/current'
    end

    context 'Valid User Token' do
      let(:user) { create(:user) }

      before { get '/api/v1/users/current', headers: header_with_authentication(user) }

      it { expect(response).to have_http_status(:success) }

      it 'returns valid user in json' do
        expect(json).to eql(serialized(Api::V1::UserSerializer, user))
      end
    end
  end

  describe 'POST /api/v1/users' do
    context 'Valid Params' do
      let(:user_params) { attributes_for(:user) }

      before { post '/api/v1/users/', params: { user: user_params } }

      it 'returns status created (201)' do
        expect(response).to(have_http_status(:created))
      end

      it 'User was create on database' do
        expect do
          post '/api/v1/users/', params: { user: attributes_for(:user) }
        end.to(change { User.count }.by(1))
      end

      it 'User data was return correctly' do
        expect(json['jwt']).not_to be_nil
      end
    end

    context 'Invalid Params' do
      let(:user_params) { { foo: :bar } }

      before { post '/api/v1/users/', params: { user: user_params } }

      it 'Returns status unprocessable entity (422)' do
        expect(response).to(have_http_status(:unprocessable_entity))
      end

      context 'Returns invalid data message' do
        it { expect(json['errors'].count).to(be > 0) }
      end

      it 'User was not create on database' do
        expect do
          post '/api/v1/users/', params: { user: user_params }
        end.to(change { User.count }.by(0))
      end
    end
  end

  describe 'DELETE /api/v1/users' do
    context 'Authenticated' do
      context 'User Exists' do
        context "Resource's Owner" do
          before { @user = create(:user) }

          let(:user_params) do
            { email_confirmation: @user.email, password_confirmation: @user.password }
          end

          context 'Valid Params' do
            it 'Returns status no_content (204)' do
              delete "/api/v1/users/#{@user.id}",
                     params: { user: user_params },
                     headers: header_with_authentication(@user)
              expect(response).to have_http_status(:no_content)
            end

            it 'User was delete on database' do
              expect do
                delete "/api/v1/users/#{@user.id}",
                       params: { user: user_params },
                       headers: header_with_authentication(@user)
              end.to change { User.count }.by(-1)
            end
          end

          context 'Invalid Params' do
            context 'Incorrect email confirmation' do
              before { user_params[:email_confirmation] = FFaker::Internet.email }

              it 'Returns status unprocessable entity (422)' do
                delete "/api/v1/users/#{@user.id}",
                       params: { user: user_params },
                       headers: header_with_authentication(@user)
                expect(response).to have_http_status(:unprocessable_entity)
              end

              it "The user won't be deleted from the database" do
                expect do
                  delete "/api/v1/users/#{@user.id}",
                         params: { user: user_params },
                         headers: header_with_authentication(@user)
                end.to change { User.count }.by(0)
              end
            end

            context 'Incorrect password confirmation' do
              before { user_params[:password_confirmation] = FFaker::Internet.password }

              it 'Returns status unprocessable entity (422)' do
                delete "/api/v1/users/#{@user.id}",
                       params: { user: user_params },
                       headers: header_with_authentication(@user)
                expect(response).to have_http_status(:unprocessable_entity)
              end

              it "The user won't be deleted from the database" do
                expect do
                  delete "/api/v1/users/#{@user.id}",
                         params: { user: user_params },
                         headers: header_with_authentication(@user)
                end.to change { User.count }.by(0)
              end
            end
          end
        end

        context "Not Resource's Owner" do
          let(:user) { create(:user) }
          let(:other_user) { create(:user) }

          before do
            delete "/api/v1/users/#{other_user.id}", headers: header_with_authentication(user)
          end

          it { expect(response).to have_http_status(:forbidden) }
        end
      end

      context "User don't Exists" do
        let(:user) { create(:user) }
        let(:user_id) { -1 }

        before { delete "/api/v1/users/#{user_id}", headers: header_with_authentication(user) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end

    context 'Not Authenticated' do
      it_behaves_like :deny_without_authorization, :delete, '/api/v1/users/-1'
    end
  end
end
