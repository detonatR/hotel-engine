# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  namespace :api do
    concern :reviewable do
      resources :reviews, only: %i[index create]
    end

    resources :authors, only: %i[create index show update], concerns: :reviewable
    resources :books, only: %i[create index show update], concerns: :reviewable
    resources :users, only: %i[index show]
  end
end
