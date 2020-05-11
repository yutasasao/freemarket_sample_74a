Rails.application.routes.draw do
  root to: 'tops#show'
  resource :sales, only: [:new, :create]
end
