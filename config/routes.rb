Rails.application.routes.draw do
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
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
    resources :customers, only:[:index,:show,:edit,:update]
    resources :orders, only:[:index,:show,:update]
    resources :items, only:[:index,:new,:create,:show,:edit,:update]
    resources :genres, only:[:index,:create,:edit,:update]
    resources :orders, only:[:show,:update]
    resources :orders_details, only:[:update]
  end

  #public
  scope module: :public do
    resources :customers, only:[:show,:edit,:update]
    get "customers/unsubscribe" =>"customers#unsubscribe", as: "unsubscribe"
    patch "customers/withdraw" => "customers#withdraw", as: "withdraw"
    resources :orders, only:[:new,:index,:show,:create] do
      collection do
          post 'confirm'
          get 'thanx'
        end
      end
    resources :items, only:[:index,:show]
    resources :cart_items, only:[:index,:update,:destroy,:create] do
      collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end
    resources :shipping_addresses, only:[:index,:edit,:create,:update,:destroy]

  end

end
