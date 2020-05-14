Rails.application.routes.draw do

  root to: 'tops#index'
  resource :sales, only: [:new, :create]
  resource :users, only: [:show]
  resource :items, only: [:index]
  resources :sign_up, only: [:index]
end
