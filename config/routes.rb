Rails.application.routes.draw do
  resources :expendables
  resources :bought_things
  resources :buy_things
  resources :thing_categories
  resources :categories
  resources :things
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end