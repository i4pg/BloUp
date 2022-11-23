Rails.application.routes.draw do
  # TODO: user_route_url
  devise_for :users
  root 'articles#index'
  resources :articles
end
