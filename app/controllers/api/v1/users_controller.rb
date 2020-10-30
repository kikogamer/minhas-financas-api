# frozen_string_literal: true

module Api
  module V1
    # UsersController
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user, only: %i[current]

      def create
        user = User.new(user_params)
        if user.save
          auth_token = Knock::AuthToken.new payload: { sub: user.id }
          render json: auth_token, status: :created
        else
          render json: { errors: user.errors },
                 status: :unprocessable_entity
        end
      end

      def current
        render json: current_user
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
