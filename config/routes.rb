Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users

  resources :articles do
    resources :comments, only: :create
  end

  resources :users, only: %i[index show]
  resources :friendships, except: %i[new edit]
  resources :likes, only: %i[create]
end
