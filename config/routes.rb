# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    resources :offers, only: [:create]
    resources :requests, only: [:create, :index], constraints: { format: 'json' }
  end
end
