# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_for :doctors
  devise_for :pharmacists

  resources :medical_records
  resources :share_records, only: %i[index create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
