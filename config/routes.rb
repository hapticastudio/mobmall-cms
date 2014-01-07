MobMall::Application.routes.draw do
  resources :password_resets, only: [:new, :create, :edit, :update]
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:edit, :update]

  resources :locals, only: [:edit, :update]

  namespace :moderator do
    resources :panel, only: :index
    resources :locals, only: [:show] do
      resources :events, only: [:new, :create, :edit, :update]
    end

    root to: "panel#index"
  end

  namespace :admin do
    resources :panel, only: :index
    resources :notifications, only: :create
    resources :devices, only: :index
    resource :devices, only: :destroy
    resources :locals, only: [:index, :new, :create]

    resources :local_contents, only: :index do
      member do
        patch :confirm
        patch :reject
      end
    end

    resources :users, only: [:new, :create, :index, :destroy] do
      member do
        patch :promote
        patch :degrade
      end
    end

    root to: "panel#index"
  end

  namespace :api, defaults: { format: "json" } do
    namespace :v1, defaults: { format: "json" } do
      resources :devices, only: [:create, :update]
      resources :content, only: :index
    end
  end

  get "logout" => "sessions#destroy", :as => "logout"

  root to: "sessions#new"
end
