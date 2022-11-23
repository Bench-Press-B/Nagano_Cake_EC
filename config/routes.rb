Rails.application.routes.draw do
  get 'searches/search'
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
    resources :customers, only:[:show,:edit,:update, :index]
    resources :orders, only:[:index,:show,:update] do
      member do
        get :current_index
      resource :order_details,only: [:update]
    end
    end
    resources :items, only:[:index,:new,:create,:show,:edit,:update]
    resources :genres, only:[:index,:create,:edit,:update]
    resources :orders, only:[:show,:update]
    get '/search' => 'searches#search'

  end

  #public
  scope module: :public do
    resources :customers, only:[:show,:edit,:update] do
     collection do
       get 'unsubscribe'
       patch 'withdraw'
     end
   end
    resources :orders, only:[:new,:index,:show,:create] do
     collection do
       post 'confirm'
       get 'thanx'
     end
   end
    resources :items, only:[:index,:show] do
      collection do
        get 'genre/:id'=> 'items#genre', as:'genre'
      end
    end
    resources :cart_items, only:[:index,:update,:destroy,:create] do
      collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end
    resources :shipping_addresses, only:[:index,:edit,:create,:update,:destroy]
    get '/search' => 'searches#search'

  end

end
