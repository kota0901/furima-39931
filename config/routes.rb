Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    get 'orders/index/:id', to: 'orders#index', as: 'index_order'
    post 'orders/create/:id', to: 'orders#create', as: 'place_order'
  end 
end
