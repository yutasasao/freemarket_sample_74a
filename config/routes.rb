Rails.application.routes.draw do
  root to: 'items#index'
  resource :sales, only: [:new, :create]
  resource :users, only: [:show]
  resource :items, only: [:index]
end
