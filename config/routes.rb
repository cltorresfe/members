Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :statuses
  resources :responsibilities
  resources :members
  resources :churches

  root 'members#index'
  devise_for :users

  # Serve websocket cable requests inprocess
  # mount ActionCable.server => '/cable'
end
