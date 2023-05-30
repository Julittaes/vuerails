Rails.application.routes.draw do
  resources :ratings
  resources :properties
  resources :accounts
  get "welcome/index"
  # get "properties/rating_count"
  # get '/rating_count', to: 'properties#rating_count'
  root to: "welcome#index"
end
