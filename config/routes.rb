Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get    '/users/:id/followings', to: 'users#followings' , :as => :users_followings
  get    '/users/:id/followers', to: 'users#followers' ,  :as => :users_followers
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
