Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root   "static_pages#home"
  get    "/about",  to: "static_pages#about"
  get    "/term",   to: "static_pages#term"
  get    "/signup", to: "users#new"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :articles do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection { get :search }
  end
  resources :users do
    collection { get :search }
    collection { get :following, :followers }
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]

  resource :session, only: [:new, :create, :destroy]
  resource :account, only: [:show, :edit, :update] do
    get :following, :followers
    get :favorites
  end
  resource :password, only: [:show, :edit, :update]
end
