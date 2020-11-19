# frozen_string_literal: true

# AdminConstraint
class AdminConstraint
  def matches?(request)
    return true if ENV.fetch('RAILS_ENV', 'development') == 'development'

    return false unless request.headers['Authorization']

    token = request.headers['Authorization'].split(' ')[1]
    user_id = Knock::AuthToken.new(token: token).payload['sub']
    user = User.find(user_id)
    user.admin?
  end
end
