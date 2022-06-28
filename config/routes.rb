# frozen_string_literal: true

Rails.application.routes.draw do
  get 'categories/index'
  resources :items
  devise_for :users
  root to: 'items#index'
  get 'homes/about'
end
