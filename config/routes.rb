ServiceWatcher::Application.routes.draw do
  devise_for :users
  
  namespace :dashboard do
    get :index
  end
  
  resources :groups
  resources :plugins
  resources :reporters
  resources :services
  resources :users
  
  root 'dashboard#index'
end
