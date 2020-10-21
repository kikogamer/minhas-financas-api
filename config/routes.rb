# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token', to: 'user_token#create'
      resources :users, only: %i[create]
    end
  end
end
