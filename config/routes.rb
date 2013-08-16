MobMall::Application.routes.draw do
  resources :password_resets, only: [:new, :create, :edit, :update]
  resource :sessions, only: [:new, :create, :destroy]
  resources :panel, only: :index
  
  get "logout" => "sessions#destroy", :as => "logout"

  root to: "sessions#new"
end
