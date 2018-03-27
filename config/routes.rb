Rails.application.routes.draw do

  get 'users/new'
  get "signup" => "users#new"
  get "admin/users" => "users#index"
  resources :users, :except => :index

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/tasks/mypage' => 'tasks#mypage'
  get '/tasks/search/' => 'tasks#search'
  post '/tasks/:id/read' => 'tasks#put_in_read'
  resources :tasks
  root 'tasks#index'

  get '*path', to: 'application#render_404'
  post '*not_found' => 'application#routing_error'
  get  '*unmatched_route' => 'application#routing_error', format: false

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
