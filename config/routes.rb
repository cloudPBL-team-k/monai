Rails.application.routes.draw do
  get '/things/search', to: 'things#search'
  get '/buy_things/exists_bought', to: 'buy_things#exists_bought'
  resources :expendables
  resources :bought_things
  resources :buy_things
  resources :thing_categories
  resources :categories
  resources :things
  resources :users
  resources :thing_aliases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
