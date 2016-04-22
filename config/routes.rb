# == Route Map
#
#                         Prefix Verb       URI Pattern                               Controller#Action
#         new_admin_user_session GET        /admin/login(.:format)                    active_admin/devise/sessions#new
#             admin_user_session POST       /admin/login(.:format)                    active_admin/devise/sessions#create
#     destroy_admin_user_session DELETE|GET /admin/logout(.:format)                   active_admin/devise/sessions#destroy
#            admin_user_password POST       /admin/password(.:format)                 active_admin/devise/passwords#create
#        new_admin_user_password GET        /admin/password/new(.:format)             active_admin/devise/passwords#new
#       edit_admin_user_password GET        /admin/password/edit(.:format)            active_admin/devise/passwords#edit
#                                PATCH      /admin/password(.:format)                 active_admin/devise/passwords#update
#                                PUT        /admin/password(.:format)                 active_admin/devise/passwords#update
#                     admin_root GET        /admin(.:format)                          admin/dashboard#index
#       batch_action_admin_users POST       /admin/users/batch_action(.:format)       admin/users#batch_action
#                    admin_users GET        /admin/users(.:format)                    admin/users#index
#                                POST       /admin/users(.:format)                    admin/users#create
#                 new_admin_user GET        /admin/users/new(.:format)                admin/users#new
#                edit_admin_user GET        /admin/users/:id/edit(.:format)           admin/users#edit
#                     admin_user GET        /admin/users/:id(.:format)                admin/users#show
#                                PATCH      /admin/users/:id(.:format)                admin/users#update
#                                PUT        /admin/users/:id(.:format)                admin/users#update
#                                DELETE     /admin/users/:id(.:format)                admin/users#destroy
# batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format) admin/admin_users#batch_action
#              admin_admin_users GET        /admin/admin_users(.:format)              admin/admin_users#index
#                                POST       /admin/admin_users(.:format)              admin/admin_users#create
#           new_admin_admin_user GET        /admin/admin_users/new(.:format)          admin/admin_users#new
#          edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)     admin/admin_users#edit
#               admin_admin_user GET        /admin/admin_users/:id(.:format)          admin/admin_users#show
#                                PATCH      /admin/admin_users/:id(.:format)          admin/admin_users#update
#                                PUT        /admin/admin_users/:id(.:format)          admin/admin_users#update
#                                DELETE     /admin/admin_users/:id(.:format)          admin/admin_users#destroy
#     batch_action_admin_members POST       /admin/members/batch_action(.:format)     admin/members#batch_action
#                  admin_members GET        /admin/members(.:format)                  admin/members#index
#                                POST       /admin/members(.:format)                  admin/members#create
#               new_admin_member GET        /admin/members/new(.:format)              admin/members#new
#              edit_admin_member GET        /admin/members/:id/edit(.:format)         admin/members#edit
#                   admin_member GET        /admin/members/:id(.:format)              admin/members#show
#                                PATCH      /admin/members/:id(.:format)              admin/members#update
#                                PUT        /admin/members/:id(.:format)              admin/members#update
#                                DELETE     /admin/members/:id(.:format)              admin/members#destroy
#                admin_dashboard GET        /admin/dashboard(.:format)                admin/dashboard#index
#    batch_action_admin_churches POST       /admin/churches/batch_action(.:format)    admin/churches#batch_action
#                 admin_churches GET        /admin/churches(.:format)                 admin/churches#index
#                                POST       /admin/churches(.:format)                 admin/churches#create
#               new_admin_church GET        /admin/churches/new(.:format)             admin/churches#new
#              edit_admin_church GET        /admin/churches/:id/edit(.:format)        admin/churches#edit
#                   admin_church GET        /admin/churches/:id(.:format)             admin/churches#show
#                                PATCH      /admin/churches/:id(.:format)             admin/churches#update
#                                PUT        /admin/churches/:id(.:format)             admin/churches#update
#                                DELETE     /admin/churches/:id(.:format)             admin/churches#destroy
#                 admin_comments GET        /admin/comments(.:format)                 admin/comments#index
#                                POST       /admin/comments(.:format)                 admin/comments#create
#                  admin_comment GET        /admin/comments/:id(.:format)             admin/comments#show
#                                DELETE     /admin/comments/:id(.:format)             admin/comments#destroy
#                       statuses GET        /statuses(.:format)                       statuses#index
#                                POST       /statuses(.:format)                       statuses#create
#                     new_status GET        /statuses/new(.:format)                   statuses#new
#                    edit_status GET        /statuses/:id/edit(.:format)              statuses#edit
#                         status GET        /statuses/:id(.:format)                   statuses#show
#                                PATCH      /statuses/:id(.:format)                   statuses#update
#                                PUT        /statuses/:id(.:format)                   statuses#update
#                                DELETE     /statuses/:id(.:format)                   statuses#destroy
#               responsibilities GET        /responsibilities(.:format)               responsibilities#index
#                                POST       /responsibilities(.:format)               responsibilities#create
#             new_responsibility GET        /responsibilities/new(.:format)           responsibilities#new
#            edit_responsibility GET        /responsibilities/:id/edit(.:format)      responsibilities#edit
#                 responsibility GET        /responsibilities/:id(.:format)           responsibilities#show
#                                PATCH      /responsibilities/:id(.:format)           responsibilities#update
#                                PUT        /responsibilities/:id(.:format)           responsibilities#update
#                                DELETE     /responsibilities/:id(.:format)           responsibilities#destroy
#                        members GET        /members(.:format)                        members#index
#                                POST       /members(.:format)                        members#create
#                     new_member GET        /members/new(.:format)                    members#new
#                    edit_member GET        /members/:id/edit(.:format)               members#edit
#                         member GET        /members/:id(.:format)                    members#show
#                                PATCH      /members/:id(.:format)                    members#update
#                                PUT        /members/:id(.:format)                    members#update
#                                DELETE     /members/:id(.:format)                    members#destroy
#                       churches GET        /churches(.:format)                       churches#index
#                                POST       /churches(.:format)                       churches#create
#                     new_church GET        /churches/new(.:format)                   churches#new
#                    edit_church GET        /churches/:id/edit(.:format)              churches#edit
#                         church GET        /churches/:id(.:format)                   churches#show
#                                PATCH      /churches/:id(.:format)                   churches#update
#                                PUT        /churches/:id(.:format)                   churches#update
#                                DELETE     /churches/:id(.:format)                   churches#destroy
#                     ministries GET        /ministries(.:format)                     ministries#index
#                                POST       /ministries(.:format)                     ministries#create
#                   new_ministry GET        /ministries/new(.:format)                 ministries#new
#                  edit_ministry GET        /ministries/:id/edit(.:format)            ministries#edit
#                       ministry GET        /ministries/:id(.:format)                 ministries#show
#                                PATCH      /ministries/:id(.:format)                 ministries#update
#                                PUT        /ministries/:id(.:format)                 ministries#update
#                                DELETE     /ministries/:id(.:format)                 ministries#destroy
#               new_user_session GET        /users/sign_in(.:format)                  devise/sessions#new
#                   user_session POST       /users/sign_in(.:format)                  devise/sessions#create
#           destroy_user_session DELETE     /users/sign_out(.:format)                 devise/sessions#destroy
#                  user_password POST       /users/password(.:format)                 devise/passwords#create
#              new_user_password GET        /users/password/new(.:format)             devise/passwords#new
#             edit_user_password GET        /users/password/edit(.:format)            devise/passwords#edit
#                                PATCH      /users/password(.:format)                 devise/passwords#update
#                                PUT        /users/password(.:format)                 devise/passwords#update
#       cancel_user_registration GET        /users/cancel(.:format)                   devise/registrations#cancel
#              user_registration POST       /users(.:format)                          devise/registrations#create
#          new_user_registration GET        /users/sign_up(.:format)                  devise/registrations#new
#         edit_user_registration GET        /users/edit(.:format)                     devise/registrations#edit
#                                PATCH      /users(.:format)                          devise/registrations#update
#                                PUT        /users(.:format)                          devise/registrations#update
#                                DELETE     /users(.:format)                          devise/registrations#destroy
#             authenticated_root GET        /                                         members#index
#           unauthenticated_root GET        /                                         devise/sessions#new
#

Rails.application.routes.draw do
  resources :attendances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :statuses
  resources :responsibilities
  resources :members, except: :show
  resources :churches
  resources :ministries, except: :show

  devise_for :users

  root 'members#index'

  # Serve websocket cable requests inprocess
  # mount ActionCable.server => '/cable'
end
