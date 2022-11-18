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

  get "home/about"=>"homes#about"

  get "admins/items" => "admins/items#index"
  get "admins/items/new" => "admins/items#new", as:"new_admins_item"
  post "admins/items" => "admins/items#create"
  get "admins/items/:id" => "admins/items#show", as:"admins_item"
  get "admins/items/:id/edit" => "admins/items#edit", as:"edit_admins_item"
  patch "admins/items/:id" => "admins/items#update"

  get "public/items" => "public/items#index"
  get "public/items/:id" => "public/items#show"


end
