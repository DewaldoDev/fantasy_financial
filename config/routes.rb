Rails.application.routes.draw do

	root to: "users#home"

  resources :portfolios do
    resources :stocks, controller: 'owned_stocks'
  end

  resources :users
  resources :groups
  resources :stocks, controller: 'base_stocks'

# User session routes
  resources :user_sessions
  get 'login' => 'user_sessions#new', :as => :login
	post 'logout' => 'user_sessions#destroy', :as => :logout

end
