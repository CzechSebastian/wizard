Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :new ]
  root to: 'users#index'
  resources :maps, only: [:index]
end
