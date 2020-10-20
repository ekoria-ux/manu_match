Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root   "static_pages#home"
  get    "/about",  to: "static_pages#about"
  get    "/signup", to: "users#new"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :articles
  resources :users do
    collection { get "search" }
  end
end
