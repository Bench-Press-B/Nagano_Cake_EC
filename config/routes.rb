Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:      'admin/passwords',
    registrations: 'admin/registrations'
  }

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  root to: "homes#top"
  get "home/about"=>"homes#about", as: 'about'
  
  #admin
  namespace :admin do
    resources :customers
    resources :orders, only:[:index,:show,:update]
    resources :items
    resources :genres
    resources :orders
    resources :orders_details
  end
  
  #public
  scope module: :public do  
    resources :customers
    resources :orders, only:[:index, :show, :update]
    resources :items
    resources :cart_items
    resources :shipping_addresses
  
  end
  
end
