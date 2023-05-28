Rails.application.routes.draw do
  resources :ratings
  resources :locations
  resources :properties
  resources :accounts
  get "welcome/index"
  root to: "welcome#index"
end
