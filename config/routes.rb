# frozen_string_literal: true

require 'sidekiq/web'
require 'constraints/admin_constraint'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
      resources :users, only: %i[create destroy] do
        get 'current', on: :collection
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new
end
