# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name                  { FFaker::Lorem.word }
    email                 { FFaker::Internet.email }
    password              { FFaker::Internet.password }
    password_confirmation { password }
  end
end
