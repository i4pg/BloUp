Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :articles do
    resources :comments, only: :create
  end

  resources :users, only: %i[index show]
  resources :friend_requests, except: %i[new edit]
  resources :likes, only: %i[create]
end
