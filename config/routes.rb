# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin_orders/index'
  get 'orders/new'
  resources :orders
  get 'carts/index'
  resources :inline_items


  get 'search', to: 'search#index'
  get 'categories/index'
  resources :items
  resources :categories

  get 'items/index'
  get 'homes/about'
  root to: 'items#index'
  devise_for :users , controllers: {
    sessions: 'users/sessions'
  }
end
