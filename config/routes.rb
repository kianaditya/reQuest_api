# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    resources :offers, only: %i[:create show update]
    resources :karma_points, only: [:index], constraints: { format: 'json' }
    resources :requests, only: %i[create index], constraints: { format: 'json' }
  end
end
