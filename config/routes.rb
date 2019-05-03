Rails.application.routes.draw do
  root 'sessions#new'

  post 'sessions/join'
end
