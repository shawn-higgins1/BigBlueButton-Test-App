# frozen_string_literal: true

Rails.application.routes.draw do
  root 'recordings#index'
  get  '/home', to: 'recordings#home'
  delete '/recordings/:id', to: 'recordings#destroy'

  resources :sessions
  resources :moderators
end
