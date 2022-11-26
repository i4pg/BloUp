Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  # TODO: user_route_url
  devise_for :users
  root 'articles#index'
  resources :articles
end
