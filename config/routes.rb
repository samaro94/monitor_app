Rails.application.routes.draw do
  devise_for :users,
             path: "users",
             module: "users"

  get 'home/index'
  # Defines the root path route ("/")
  root "home#index"

end
