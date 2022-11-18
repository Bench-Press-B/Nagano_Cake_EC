Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  devise_for :admin
  devise_for :customers
  get "home/about"=>"homes#about"
  
  #admin
  namespace :admin do
    resources :orders, only:[:index,:show,:update]
    
  end
  
  
  #public
  scope module: :public do
  
    #orders
    resources :orders, only:[:index, :show, :update]
  
  end
  
end
