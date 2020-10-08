# frozen_string_literal: true

module Api
  module V1
    # UsersController
    class UsersController < Api::V1::ApiController
      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
