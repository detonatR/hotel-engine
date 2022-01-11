# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :authors, only: %i[create index show update]
    resources :books, only: %i[create index show update]
    resources :users, only: %i[create index show update]
  end
end
