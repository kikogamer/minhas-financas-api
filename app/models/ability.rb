# frozen_string_literal: true

# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, User, id: user.id
  end
end
