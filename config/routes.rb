# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'carts/index'
  # get 'orders/new'
  # get 'categories/index'
  # get 'items/index'
  # get 'homes/about'
  root to: 'homes#index'
  resources :orders
  resources :carts
  resources :inline_items
  resources :items
  resources :categories
  resources :homes
  resources :search, only: [:index]


  # get 'search', to: 'search#index'
  resources :orders do
    get :search_for_members, on: :collection
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
