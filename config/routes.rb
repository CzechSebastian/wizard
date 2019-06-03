Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :new ]
  resources :pages, only: [:index]
  resources :districts, only: [:index, :show]
  resources :landing, only: [:index]
  root to: 'landing#index'
  resources :maps, only: [:index]
end
