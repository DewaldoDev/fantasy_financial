Rails.application.routes.draw do

	root to: "users#home"

  resources :portfolios
	get '/stack', to: 'users#stack'
  resources :users
  resources :groups
  post "/groups/:id/participation", to: "groups#join"

  resources :stocks, controller: 'base_stocks'
  resources :owned_stocks

# User session routes
  resources :user_sessions
  get 'login' => 'user_sessions#new', :as => :login
	post 'logout' => 'user_sessions#destroy', :as => :logout

end
