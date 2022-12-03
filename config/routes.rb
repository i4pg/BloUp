Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users

  resources :articles
  resources :users, only: %i[index show]
  resources :friendships, except: %i[new edit]
  resources :likes, only: %i[create destroy]
end
