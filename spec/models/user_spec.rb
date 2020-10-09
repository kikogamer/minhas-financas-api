# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) { attributes_for(:user) }

  it 'is valid with name, email and password' do
    expect(create(:user)).to be_valid
  end

  it 'is invalid password with length smaller than 7' do
    user_params[:password] = FFaker::Internet.password(1, 7)
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid password with length greater than 72' do
    user_params[:password] = FFaker::Internet.password(73, 999)
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid without name' do
    user_params[:name] = nil
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid without email' do
    user_params[:email] = nil
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid without password' do
    user_params[:password] = nil
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid with invalid email format' do
    user_params[:email] = FFaker::Lorem.word
    expect(User.create(user_params)).to_not be_valid
  end

  it 'is invalid with duplicated email' do
    other_user_params = attributes_for(:user)
    other_user_params[:email] = user_params[:email]

    User.create(user_params)
    expect(User.create(other_user_params)).to_not be_valid
  end
end
