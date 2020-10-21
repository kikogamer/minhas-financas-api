# frozen_string_literal: true

module Serializers
  def self.serialize_object(object)
    JSON.parse(object.to_json).symbolize_keys
  end
end
