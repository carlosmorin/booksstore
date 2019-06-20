# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books_stores
  resources :books do
    member do
      get :modal_asign
    end
  end

  resources :stores
  resources :units
  resources :categories
  resources :brands
  devise_for :users
  get 'dashboard/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  # root 'brands#index'
  get '/stores/:id/show_content', to: 'stores#show_content'

  # get '/books/:id/modal_asign', to: 'books#modal_asign'
end
