MobMall::Application.routes.draw do
  resource :sessions, only: [:new, :create]
  resources :panel, only: :index

  root to: "sessions#new"
end
