# frozen_string_literal: true

module Api
  module V1
    # UsersController
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user, only: %i[current destroy]
      before_action :set_user, only: %i[destroy]
      load_and_authorize_resource except: %i[create current]

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

      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
