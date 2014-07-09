ServiceWatcher::Application.routes.draw do
  devise_for :users

  namespace :dashboard do
    get :index
    post :check_all
  end

  resources :groups do
    resources :group_reporters
    resources :services do
      post :check, :on => :member
    end
  end
  resources :locales, :only => :create
  resources :plugins
  resources :reporters
  resources :users

  root 'dashboard#index'
end
