Rails.application.routes.draw do
  root "home#index"

  # route admin
  namespace :admin do
    resources :users, only: [ :new, :create, :edit, :update, :index, :destroy ]
    get "cars/:user_id", to: "cars#cars_for_user", as: "cars_for_user"
    get "approved/:id", to: "cars#approve", as: "approve_admin_car"
    get "rejected/:id", to: "cars#reject", as: "reject_admin_car"
  end

  get "home", to: "home#index", as: "home"

  get "logout", to: "sessions#logout", as: "logout"


  resources :sessions, only: [ :new, :create ]
  resources :cars, only: [ :index, :edit, :update ]
end
