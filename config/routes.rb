Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users

  resources :users, only: %i[index show]
  resources :friend_requests, except: %i[new edit]
  resources :articles do
    resources :likes
  end
end
