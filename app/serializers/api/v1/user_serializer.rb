# frozen_string_literal: true

module Api
  module V1
    # UserSerializer
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name, :email
    end
  end
end
