# frozen_string_literal: true

require 'constraints/admin_constraint'
require('rails_helper')

RSpec.describe(AdminConstraint, type: :request) do
  describe 'AdminConstraint' do
    context 'Authenticated' do
      it 'Role user' do
        user = create(:user)

        expect do
          get '/sidekiq', headers: header_with_authentication(user)
        end.to raise_error(ActionController::RoutingError)
      end

      context 'Role admin' do
        let(:user) { create(:user, role: :admin) }
        before { get '/sidekiq', headers: header_with_authentication(user) }

        it { expect(response).to(have_http_status(:ok)) }
      end
    end

    it 'Not Authenticated' do
      expect do
        get '/sidekiq'
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
