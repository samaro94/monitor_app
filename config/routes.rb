Rails.application.routes.draw do

  resources :service_blocks, only: :index
  get 'service_blocks/modify/:service_id', to: "service_blocks#modify"
  post 'service_blocks/update/:service_id', to: "service_blocks#update"

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
