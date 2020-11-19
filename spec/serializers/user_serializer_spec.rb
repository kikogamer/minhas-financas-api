# frozen_string_literal: true

require('rails_helper')

RSpec.describe Api::V1::UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:serializer) { described_class.new(user) }

  let(:user_json) { Serializers.serialize_object(user) }

  it 'has a valid json' do
    expect(serializer.to_json).to include_json(user_json.except(:password_digest, :created_at, :updated_at, :role))
  end
end
