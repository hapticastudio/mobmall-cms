MobMall::Application.routes.draw do
  resources :password_resets, only: [:new, :create, :edit, :update]
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :destroy, :edit, :update] do
    member do
      patch :promote
      patch :degrade
    end
  end

  resources :locals, only: [:index, :new, :create, :edit, :update]

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

    resources :local_contents, only: :index do
      member do
        patch :confirm
        patch :reject
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
