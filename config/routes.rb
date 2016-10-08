require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :attendances, only: [:index, :create]
  resources :tithes, only: [:new, :create, :update]
  resources :churches, only: [:new, :create]
  resources :families, except: :show
  resources :members do
    member do
      post :send_mail, format: :js
      post :associated_family
      post :add_tithes
    end
  end
  resources :ministries, except: :show
  resources :responsibilities

  get 'profile', to: 'users#edit', as: :edit_profile
  put 'profile', to: 'users#update', as: :profile
  get 'search' => 'search#search', as: :search
  get 'autocomplete' => 'search#autocomplete', as: :autocomplete,
      constraints: { format: :json }, defaults: { format: :json }

  root 'main#index'

  # Serve websocket cable requests inprocess
  # mount ActionCable.server => '/cable'
end

# == Route Map
#
#                   Prefix Verb   URI Pattern                              Controller#Action
#              sidekiq_web        /sidekiq                                 Sidekiq::Web
#         new_user_session GET    /users/sign_in(.:format)                 devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                 devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                devise/sessions#destroy
#            user_password POST   /users/password(.:format)                devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)            devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)           devise/passwords#edit
#                          PATCH  /users/password(.:format)                devise/passwords#update
#                          PUT    /users/password(.:format)                devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                  users/registrations#cancel
#        user_registration POST   /users(.:format)                         users/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                 users/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                    users/registrations#edit
#                          PATCH  /users(.:format)                         users/registrations#update
#                          PUT    /users(.:format)                         users/registrations#update
#                          DELETE /users(.:format)                         users/registrations#destroy
#              attendances GET    /attendances(.:format)                   attendances#index
#                          POST   /attendances(.:format)                   attendances#create
#                   tithes POST   /tithes(.:format)                        tithes#create
#                new_tithe GET    /tithes/new(.:format)                    tithes#new
#                    tithe PATCH  /tithes/:id(.:format)                    tithes#update
#                          PUT    /tithes/:id(.:format)                    tithes#update
#                 churches POST   /churches(.:format)                      churches#create
#               new_church GET    /churches/new(.:format)                  churches#new
#                 families GET    /families(.:format)                      families#index
#                          POST   /families(.:format)                      families#create
#               new_family GET    /families/new(.:format)                  families#new
#              edit_family GET    /families/:id/edit(.:format)             families#edit
#                   family PATCH  /families/:id(.:format)                  families#update
#                          PUT    /families/:id(.:format)                  families#update
#                          DELETE /families/:id(.:format)                  families#destroy
#         send_mail_member POST   /members/:id/send_mail(.:format)         members#send_mail
# associated_family_member POST   /members/:id/associated_family(.:format) members#associated_family
#        add_tithes_member POST   /members/:id/add_tithes(.:format)        members#add_tithes
#                  members GET    /members(.:format)                       members#index
#                          POST   /members(.:format)                       members#create
#               new_member GET    /members/new(.:format)                   members#new
#              edit_member GET    /members/:id/edit(.:format)              members#edit
#                   member GET    /members/:id(.:format)                   members#show
#                          PATCH  /members/:id(.:format)                   members#update
#                          PUT    /members/:id(.:format)                   members#update
#                          DELETE /members/:id(.:format)                   members#destroy
#               ministries GET    /ministries(.:format)                    ministries#index
#                          POST   /ministries(.:format)                    ministries#create
#             new_ministry GET    /ministries/new(.:format)                ministries#new
#            edit_ministry GET    /ministries/:id/edit(.:format)           ministries#edit
#                 ministry PATCH  /ministries/:id(.:format)                ministries#update
#                          PUT    /ministries/:id(.:format)                ministries#update
#                          DELETE /ministries/:id(.:format)                ministries#destroy
#         responsibilities GET    /responsibilities(.:format)              responsibilities#index
#                          POST   /responsibilities(.:format)              responsibilities#create
#       new_responsibility GET    /responsibilities/new(.:format)          responsibilities#new
#      edit_responsibility GET    /responsibilities/:id/edit(.:format)     responsibilities#edit
#           responsibility GET    /responsibilities/:id(.:format)          responsibilities#show
#                          PATCH  /responsibilities/:id(.:format)          responsibilities#update
#                          PUT    /responsibilities/:id(.:format)          responsibilities#update
#                          DELETE /responsibilities/:id(.:format)          responsibilities#destroy
#             edit_profile GET    /profile(.:format)                       users#edit
#                  profile PUT    /profile(.:format)                       users#update
#                   search GET    /search(.:format)                        search#search
#             autocomplete GET    /autocomplete(.:format)                  search#autocomplete {:format=>:json}
#                     root GET    /                                        main#index
#
