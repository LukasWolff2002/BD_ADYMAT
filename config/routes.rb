Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Defines the root path route ("/")
  root 'home#index'

  resources :users
  resources :customers
  resources :machineries

  get "qr/scan", to: "qr#scan", as: :qr_scan

  get 'qr/m/:qr_token', to: 'machineries#show_by_qr', as: :machinery_qr

  get 'machineries/:id/download_qr', to: 'machineries#download_qr', as: :download_qr_machinery




  resource :password, only: [:edit, :update]
end
