Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :users, only: %i[index show]
  resources :articles
end
