Rails.application.routes.draw do
  resources :friend_requests
  root 'articles#index'
  devise_for :users

  resources :articles
  resources :users, only: %i[index show]
  # resources :friend_requests, only: %i[create destory update]
  # resource :dashboard, only: [:show]
end
