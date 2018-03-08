Rails.application.routes.draw do

  get 'users/new'
  get "signup" => "users#new"
  resources :users

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # get 'users/index'
  #
  # get 'users/create'
  #
  # get 'users/new'

  resources :task
  root 'task#index'
  # get '/new' => 'task#new'
  #
  # get 'task/show'
  #
  # get 'task/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
