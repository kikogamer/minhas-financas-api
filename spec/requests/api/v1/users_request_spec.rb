# frozen_string_literal: true

require('rails_helper')

RSpec.describe('Users', type: :request) do
  describe 'GET /api/v1/users/current' do
    context 'Unauthenticated' do
      it_behaves_like :deny_without_authorization, :get, '/api/v1/users/current'
    end

    context 'Authenticated' do
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
end
