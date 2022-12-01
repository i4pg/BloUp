Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users

  resources :users, only: %i[index show]
  resources :friendships, except: %i[new edit]
  resources :articles do
    resources :likes
  end
end
