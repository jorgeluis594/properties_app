Rails.application.routes.draw do
  devise_for :users

  root to: "properties#index"
  resources :properties

  namespace :admin do
    get "/", to: "properties#index"

    get '/', to: 'properties#index', as: 'user_root'

    resources :properties
  end
end
