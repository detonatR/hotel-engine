# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :authors, only: %i[create index show update]
    resources :books, only: %i[create index show update]
    resources :users, only: %i[index show]
  end
end
