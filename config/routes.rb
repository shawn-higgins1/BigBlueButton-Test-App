Rails.application.routes.draw do
  root 'recordings#index'
  get  '/home',    to: 'recordings#home'
  
  resources :sessions
  resources :moderator
end
