# frozen_string_literal: true

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
  get '/search', to: 'search#search', as: :search

  resources :users, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
