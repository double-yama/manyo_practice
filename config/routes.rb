Rails.application.routes.draw do

  namespace :admin do
    resources :users, :except => :index
  end

  resources :users, :except => :index

  namespace :admin do
    resources :labels
  end

  # resources :labels

  namespace :admin do
  end

  namespace :admin do

  end

  resources :groups

  # collection(集合)はidなし、member(個別)はidあり

  root :to => 'tasks#index'
  get "signup" => "users#new"
  get "admin/users" => "users#index"

  # namespace :admin do
  #   resources :users, :except => :index
  # end
  resources :users, :except => :index
  resources :groups
  resources :labels
  resources :calendar
  # get '/calendar/:year/:month' => 'calendar#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :tasks do
    collection do
      get :mypage
      get :search
    end

    member do
      post :read
      post :turn_complete
    end
  end

  get '*path', to: 'application#render_404'
  post '*not_found' => 'application#routing_error'
  get  '*unmatched_route' => 'application#routing_error', format: false

end
