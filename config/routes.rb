Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'
  resource :sales, only: [:new, :create]
  resources :users, only: [:index, :show]
  resources :items, only: [:index, :new, :show]
  resources :sign_up, only: [:index]
end
