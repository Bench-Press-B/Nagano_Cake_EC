Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "homes#top"
  devise_for :users
  get "home/about"=>"homes#about", as: "about"
  
  namespace :admin do
    resources :customers, only:[:index,:show,:update]
  end
  
  scope module: :public do
    resources :customers, only: [:show,:edit,:update]
  end
   
end
