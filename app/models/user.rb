# frozen_string_literal: true

# User
class User < ApplicationRecord
  enum role: %i[user admin]

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A\S*@\S*\z/ }
  validates_length_of :password,
                      maximum: 72,
                      minimum: 8,
                      allow_nil: true,
                      allow_blank: false,
                      confirmation: true

  validates_presence_of :name, :password_confirmation
end
