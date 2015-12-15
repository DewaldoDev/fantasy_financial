Rails.application.routes.draw do

  resources :portfolios do
    resources :owned_stocks
  end

  resources :users
  resources :groups
  resources :stocks, controller: 'base_stocks'

end
