# frozen_string_literal: true

require('rails_helper')

RSpec.describe('UserToken', type: :request) do
  describe 'POST /api/v1/user_token' do
    context 'Valid Params' do
      let(:user) { create(:user) }

      before { post '/api/v1/user_token', params: { auth: { email: user.email, password: user.password } } }

      it 'returns status created (201)' do
        expect(response).to(have_http_status(:created))
      end

      it 'Token data was return correctly' do
        expect(json['jwt']).not_to be_nil
      end
    end

    context 'Invalid Params' do
      let(:auth_params) { { foo: :bar } }

      before { post '/api/v1/user_token', params: { auth: auth_params } }

      it 'Returns status not found (404)' do
        expect(response).to(have_http_status(:not_found))
      end
    end
  end
end
