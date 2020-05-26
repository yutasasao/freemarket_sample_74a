Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'tops#index'
  resource :sales, only: [:new, :create]
  resources :users, only: [:index, :show] do
    member do
      get 'sale_list'
    end
    resources :bookmarks, only: [:index]
  end
  resources :sign_up, only: [:index]

  resources :items,shallow: true do
    resources :comments, only: [:create]
    resource :bookmarks, only: %i[create destroy]
      get :bookmarks, on: :collection
    resources :buy do
      collection do
        get 'done', to: 'buy#index'
      end
    end
  end
end
