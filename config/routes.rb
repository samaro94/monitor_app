Rails.application.routes.draw do

  resources :service_blocks, only: :index
  get 'service_blocks/modify/:service_id', to: 'service_blocks#modify'
  post 'service_blocks/update/:service_id', to: 'service_blocks#update'

  resources :services do
    collection do
      get 'get_list'
      get ':id/change_status', action: 'change_status'
    end
  end

  devise_for :users,
             path: 'users',
             module: 'users'

  get 'home/index'
  # Defines the root path route ("/")
  root 'home#index'

  # resources :shifts, only: :index do
  #   get 'service', action: "service"
  # end
  get '/shifts/:shift_type', to: 'shifts#index'
  get '/get_shifts/:shift_type', to: 'shifts#get_list'
  post '/shifts/modify_all/', to: 'shifts#modify_all'

end
