# frozen_string_literal: true

module Api
  module V1
    # ApiController
    class ApiController < ApplicationController
      include Knock::Authenticable
      include CanCan::ControllerAdditions

      rescue_from ActiveRecord::RecordNotFound do |msg|
        render(json: { message: msg }, status: :not_found)
      end

      rescue_from CanCan::AccessDenied do |msg|
        render(json: { message: msg }, status: :forbidden)
      end
    end
  end
end
