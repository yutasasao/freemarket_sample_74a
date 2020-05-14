Rails.application.routes.draw do

  root to: 'items#index'
  resource :sales, only: [:new, :create]
  resource :users, only: [:show]
  resources :items, only: [:index, :new, :show]
  resources :sign_up, only: [:index]
end
