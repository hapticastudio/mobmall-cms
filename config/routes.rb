MobMall::Application.routes.draw do
  resources :password_resets, only: [:new, :create, :edit, :update]
  resource :sessions, only: [:new, :create, :destroy]
  resources :panel, only: :index
  resources :users, only: [:new, :create, :index, :destroy, :edit, :update] do
    member do
      patch :promote
      patch :degrade
    end
  end

  resources :locals, only: [:new, :create, :edit, :update]
  
  get "logout" => "sessions#destroy", :as => "logout"

  root to: "sessions#new"
end
