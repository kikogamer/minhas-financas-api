# frozen_string_literal: true

module Requests
  module JsonHelpers
    def expect_status(expectation)
      expect(response.status).to eql(expectation)
    end

    def json
      JSON.parse(response.body)
    end
  end

  module HeaderHelpers
    def header_with_authentication(user)
      token = Knock::AuthToken.new(payload: { sub: user.id }).token
      { 'Authorization' => "Bearer #{token}" }
    end

    def header_without_authentication
      { 'content-type' => 'application/json' }
    end
  end
end
