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

  resources :locals, only: [:index, :new, :create, :edit, :update] do
    resources :events, only: [:new, :create, :edit, :update]
  end

  resources :local_contents, only: :index do
    member do
      patch :confirm
      patch :reject
    end
  end

  resources :devices, only: :index

  namespace :api, defaults: { format: "json" } do
    namespace :v1, defaults: { format: "json" } do
      resources :devices, only: [:create, :update]
      resources :content, only: :index
    end
  end
  
  get "logout" => "sessions#destroy", :as => "logout"

  root to: "sessions#new"
end
