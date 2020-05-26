
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
  resource :sales, only: [:index, :show, :new, :edit, :destroy] do

  #Ajaxで動くアクションのルートを作成
  collection do
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
  end
end
  resources :users, only: [:index, :show]
  resources :items
  resources :sign_up, only: [:index]

end