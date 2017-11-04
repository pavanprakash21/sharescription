# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_for :doctors
  devise_for :pharmacists

  resources :medical_records
  resources :share_records, only: %i[index]

  post '/share/:medical_record_id/with/:shareable_id/is/:shareable_type', to: 'share_records#create'

  get '/search/suggestions', to: 'search#index'
  get '/search', to: 'search#search', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
