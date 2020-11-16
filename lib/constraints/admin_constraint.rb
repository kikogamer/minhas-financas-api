# frozen_string_literal: true

# AdminConstraint
class AdminConstraint
  def matches?(request)
    return false unless request.headers['Authorization']

    token = request.headers['Authorization'].split(' ')[1]
    user_id = Knock::AuthToken.new(token: token).payload['sub']
    user = User.find(user_id)
    p user.admin?
    user.admin?
  end
end
