Rails.application.routes.draw do

  resources :service_blocks, only: :index do
    get 'modify/:service_id', action: "modify"
  end

  resources :services do
    collection do
      get 'get_list'
      get ':id/change_status', action: "change_status"
    end
  end

  devise_for :users,
             path: "users",
             module: "users"

  get 'home/index'
  # Defines the root path route ("/")
  root "home#index"

end
