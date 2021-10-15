Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get '/search', to: "tasks#search", as: "search_tasks"
end
