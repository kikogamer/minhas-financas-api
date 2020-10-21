# frozen_string_literal: true

module Api
  module V1
    # ApiController
    class ApiController < ApplicationController
      include Knock::Authenticable
    end
  end
end
