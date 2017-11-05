# frozen_string_literal: true

# == Route Map
#
#                         Prefix Verb   URI Pattern                              Controller#Action
#                           root GET    /                                        home#index
#               new_user_session GET    /users/sign_in(.:format)                 devise/sessions#new
#                   user_session POST   /users/sign_in(.:format)                 devise/sessions#create
#           destroy_user_session DELETE /users/sign_out(.:format)                devise/sessions#destroy
#              new_user_password GET    /users/password/new(.:format)            devise/passwords#new
#             edit_user_password GET    /users/password/edit(.:format)           devise/passwords#edit
#                  user_password PATCH  /users/password(.:format)                devise/passwords#update
#                                PUT    /users/password(.:format)                devise/passwords#update
#                                POST   /users/password(.:format)                devise/passwords#create
#       cancel_user_registration GET    /users/cancel(.:format)                  devise/registrations#cancel
#          new_user_registration GET    /users/sign_up(.:format)                 devise/registrations#new
#         edit_user_registration GET    /users/edit(.:format)                    devise/registrations#edit
#              user_registration PATCH  /users(.:format)                         devise/registrations#update
#                                PUT    /users(.:format)                         devise/registrations#update
#                                DELETE /users(.:format)                         devise/registrations#destroy
#                                POST   /users(.:format)                         devise/registrations#create
#          new_user_confirmation GET    /users/confirmation/new(.:format)        devise/confirmations#new
#              user_confirmation GET    /users/confirmation(.:format)            devise/confirmations#show
#                                POST   /users/confirmation(.:format)            devise/confirmations#create
#             new_doctor_session GET    /doctors/sign_in(.:format)               devise/sessions#new
#                 doctor_session POST   /doctors/sign_in(.:format)               devise/sessions#create
#         destroy_doctor_session DELETE /doctors/sign_out(.:format)              devise/sessions#destroy
#            new_doctor_password GET    /doctors/password/new(.:format)          devise/passwords#new
#           edit_doctor_password GET    /doctors/password/edit(.:format)         devise/passwords#edit
#                doctor_password PATCH  /doctors/password(.:format)              devise/passwords#update
#                                PUT    /doctors/password(.:format)              devise/passwords#update
#                                POST   /doctors/password(.:format)              devise/passwords#create
#     cancel_doctor_registration GET    /doctors/cancel(.:format)                devise/registrations#cancel
#        new_doctor_registration GET    /doctors/sign_up(.:format)               devise/registrations#new
#       edit_doctor_registration GET    /doctors/edit(.:format)                  devise/registrations#edit
#            doctor_registration PATCH  /doctors(.:format)                       devise/registrations#update
#                                PUT    /doctors(.:format)                       devise/registrations#update
#                                DELETE /doctors(.:format)                       devise/registrations#destroy
#                                POST   /doctors(.:format)                       devise/registrations#create
#        new_doctor_confirmation GET    /doctors/confirmation/new(.:format)      devise/confirmations#new
#            doctor_confirmation GET    /doctors/confirmation(.:format)          devise/confirmations#show
#                                POST   /doctors/confirmation(.:format)          devise/confirmations#create
#         new_pharmacist_session GET    /pharmacists/sign_in(.:format)           devise/sessions#new
#             pharmacist_session POST   /pharmacists/sign_in(.:format)           devise/sessions#create
#     destroy_pharmacist_session DELETE /pharmacists/sign_out(.:format)          devise/sessions#destroy
#        new_pharmacist_password GET    /pharmacists/password/new(.:format)      devise/passwords#new
#       edit_pharmacist_password GET    /pharmacists/password/edit(.:format)     devise/passwords#edit
#            pharmacist_password PATCH  /pharmacists/password(.:format)          devise/passwords#update
#                                PUT    /pharmacists/password(.:format)          devise/passwords#update
#                                POST   /pharmacists/password(.:format)          devise/passwords#create
# cancel_pharmacist_registration GET    /pharmacists/cancel(.:format)            devise/registrations#cancel
#    new_pharmacist_registration GET    /pharmacists/sign_up(.:format)           devise/registrations#new
#   edit_pharmacist_registration GET    /pharmacists/edit(.:format)              devise/registrations#edit
#        pharmacist_registration PATCH  /pharmacists(.:format)                   devise/registrations#update
#                                PUT    /pharmacists(.:format)                   devise/registrations#update
#                                DELETE /pharmacists(.:format)                   devise/registrations#destroy
#                                POST   /pharmacists(.:format)                   devise/registrations#create
#    new_pharmacist_confirmation GET    /pharmacists/confirmation/new(.:format)  devise/confirmations#new
#        pharmacist_confirmation GET    /pharmacists/confirmation(.:format)      devise/confirmations#show
#                                POST   /pharmacists/confirmation(.:format)      devise/confirmations#create
#           dorp_medical_records GET    /medical_records/dp/:user_id(.:format)   medical_records#dorp_index
#                medical_records GET    /medical_records(.:format)               medical_records#index
#                                POST   /medical_records(.:format)               medical_records#create
#             new_medical_record GET    /medical_records/new(.:format)           medical_records#new
#            edit_medical_record GET    /medical_records/:id/edit(.:format)      medical_records#edit
#                 medical_record GET    /medical_records/:id(.:format)           medical_records#show
#                                PATCH  /medical_records/:id(.:format)           medical_records#update
#                                PUT    /medical_records/:id(.:format)           medical_records#update
#                                DELETE /medical_records/:id(.:format)           medical_records#destroy
#       temp_revoke_share_record PATCH  /share_records/:id/temp_revoke(.:format) share_records#temp_revoke
#            permit_share_record PATCH  /share_records/:id/permit(.:format)      share_records#permit
#                  share_records GET    /share_records(.:format)                 share_records#index
#                                POST   /share_records(.:format)                 share_records#create
#                   share_record DELETE /share_records/:id(.:format)             share_records#destroy
#             search_suggestions GET    /search/suggestions(.:format)            search#index
#                          users GET    /users(.:format)                         users#index
#

Rails.application.routes.draw do
  root 'home#index'

  mount ActionCable.server => '/cable'

  devise_for :users
  devise_for :doctors
  devise_for :pharmacists

  resources :medical_records do
    get '/dp/:user_id', action: :dorp_index, on: :collection, as: :dorp
  end

  resources :share_records, only: %i[index create destroy] do
    patch :temp_revoke, on: :member
    patch :permit, on: :member
  end

  get '/search/suggestions', to: 'search#index'

  resources :users, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
