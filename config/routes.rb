# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items
  devise_for :users
  root to: 'homes#index'
  get 'homes/about'
end
