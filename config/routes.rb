require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  ActiveAdmin.routes(self)

  resources :attendances, only: [:index, :create]
  resources :responsibilities
  resources :members, except: :show
  resources :churches, only: [:new, :create]
  resources :ministries, except: :show
  resources :families, except: :show

  root 'main#index'

  # Serve websocket cable requests inprocess
  # mount ActionCable.server => '/cable'
end

# == Route Map
#
#                      Prefix Verb   URI Pattern                            Controller#Action
#            new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
#                user_session POST   /users/sign_in(.:format)               devise/sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#               user_password POST   /users/password(.:format)              devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                             PATCH  /users/password(.:format)              devise/passwords#update
#                             PUT    /users/password(.:format)              devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                users/registrations#cancel
#           user_registration POST   /users(.:format)                       users/registrations#create
#       new_user_registration GET    /users/sign_up(.:format)               users/registrations#new
#      edit_user_registration GET    /users/edit(.:format)                  users/registrations#edit
#                             PATCH  /users(.:format)                       users/registrations#update
#                             PUT    /users(.:format)                       users/registrations#update
#                             DELETE /users(.:format)                       users/registrations#destroy
#                  admin_root GET    /admin(.:format)                       admin/dashboard#index
#    batch_action_admin_users POST   /admin/users/batch_action(.:format)    admin/users#batch_action
#                 admin_users GET    /admin/users(.:format)                 admin/users#index
#                             POST   /admin/users(.:format)                 admin/users#create
#              new_admin_user GET    /admin/users/new(.:format)             admin/users#new
#             edit_admin_user GET    /admin/users/:id/edit(.:format)        admin/users#edit
#                  admin_user GET    /admin/users/:id(.:format)             admin/users#show
#                             PATCH  /admin/users/:id(.:format)             admin/users#update
#                             PUT    /admin/users/:id(.:format)             admin/users#update
#                             DELETE /admin/users/:id(.:format)             admin/users#destroy
#  batch_action_admin_members POST   /admin/members/batch_action(.:format)  admin/members#batch_action
#               admin_members GET    /admin/members(.:format)               admin/members#index
#                             POST   /admin/members(.:format)               admin/members#create
#            new_admin_member GET    /admin/members/new(.:format)           admin/members#new
#           edit_admin_member GET    /admin/members/:id/edit(.:format)      admin/members#edit
#                admin_member GET    /admin/members/:id(.:format)           admin/members#show
#                             PATCH  /admin/members/:id(.:format)           admin/members#update
#                             PUT    /admin/members/:id(.:format)           admin/members#update
#                             DELETE /admin/members/:id(.:format)           admin/members#destroy
#             admin_dashboard GET    /admin/dashboard(.:format)             admin/dashboard#index
# batch_action_admin_churches POST   /admin/churches/batch_action(.:format) admin/churches#batch_action
#              admin_churches GET    /admin/churches(.:format)              admin/churches#index
#                             POST   /admin/churches(.:format)              admin/churches#create
#            new_admin_church GET    /admin/churches/new(.:format)          admin/churches#new
#           edit_admin_church GET    /admin/churches/:id/edit(.:format)     admin/churches#edit
#                admin_church GET    /admin/churches/:id(.:format)          admin/churches#show
#                             PATCH  /admin/churches/:id(.:format)          admin/churches#update
#                             PUT    /admin/churches/:id(.:format)          admin/churches#update
#                             DELETE /admin/churches/:id(.:format)          admin/churches#destroy
#              admin_comments GET    /admin/comments(.:format)              admin/comments#index
#                             POST   /admin/comments(.:format)              admin/comments#create
#               admin_comment GET    /admin/comments/:id(.:format)          admin/comments#show
#                             DELETE /admin/comments/:id(.:format)          admin/comments#destroy
#                 attendances GET    /attendances(.:format)                 attendances#index
#                             POST   /attendances(.:format)                 attendances#create
#            responsibilities GET    /responsibilities(.:format)            responsibilities#index
#                             POST   /responsibilities(.:format)            responsibilities#create
#          new_responsibility GET    /responsibilities/new(.:format)        responsibilities#new
#         edit_responsibility GET    /responsibilities/:id/edit(.:format)   responsibilities#edit
#              responsibility GET    /responsibilities/:id(.:format)        responsibilities#show
#                             PATCH  /responsibilities/:id(.:format)        responsibilities#update
#                             PUT    /responsibilities/:id(.:format)        responsibilities#update
#                             DELETE /responsibilities/:id(.:format)        responsibilities#destroy
#                     members GET    /members(.:format)                     members#index
#                             POST   /members(.:format)                     members#create
#                  new_member GET    /members/new(.:format)                 members#new
#                 edit_member GET    /members/:id/edit(.:format)            members#edit
#                      member PATCH  /members/:id(.:format)                 members#update
#                             PUT    /members/:id(.:format)                 members#update
#                             DELETE /members/:id(.:format)                 members#destroy
#                    churches POST   /churches(.:format)                    churches#create
#                  new_church GET    /churches/new(.:format)                churches#new
#                  ministries GET    /ministries(.:format)                  ministries#index
#                             POST   /ministries(.:format)                  ministries#create
#                new_ministry GET    /ministries/new(.:format)              ministries#new
#               edit_ministry GET    /ministries/:id/edit(.:format)         ministries#edit
#                    ministry PATCH  /ministries/:id(.:format)              ministries#update
#                             PUT    /ministries/:id(.:format)              ministries#update
#                             DELETE /ministries/:id(.:format)              ministries#destroy
#                    families GET    /families(.:format)                    families#index
#                             POST   /families(.:format)                    families#create
#                  new_family GET    /families/new(.:format)                families#new
#                 edit_family GET    /families/:id/edit(.:format)           families#edit
#                      family PATCH  /families/:id(.:format)                families#update
#                             PUT    /families/:id(.:format)                families#update
#                             DELETE /families/:id(.:format)                families#destroy
#                        root GET    /                                      main#index
#
