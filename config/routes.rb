MobMall::Application.routes.draw do
  resource :sessions, only: [:new, :create]

  root to: "sessions#new"
end
