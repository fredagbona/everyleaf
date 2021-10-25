Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :tasks
  get '/search', to: "tasks#search", as: "search_tasks"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]

  namespace :admin do
    resources :users
  end
  
end
