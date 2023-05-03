Rails.application.routes.draw do
  devise_for :users

  root to: "properties#index"
  resources :properties

  namespace :admin do
    get "/", to: "properties#index"

    resources :properties
  end
end
