Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'
  # patch '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

  resources :users do
    resources :chirps, only: [:index] # get '/users/:user_id/chirps, to: 'chirps#index'
  end

  resources :chirps, only: [:show, :create] # get '/chirps/:id', to: 'chirps#show'

  resource :session, only: [:new, :create, :destroy] # only one session
  
end
