# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'categories/index'
  resources :items
  resources :categories
  devise_for :users
  get 'items/index'
  get 'homes/about'
  root to: 'homes#about'
end
