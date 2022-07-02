# frozen_string_literal: true

Rails.application.routes.draw do
  get 'carts/index'
  resources :inline_items
  get 'search', to: 'search#index'
  get 'categories/index'
  resources :items
  resources :categories
  devise_for :users
  get 'items/index'
  get 'homes/about'
  root to: 'items#index'
end
