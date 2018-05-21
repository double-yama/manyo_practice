Rails.application.routes.draw do

  get 'groups/index'

  get 'groups/new'

  get 'groups/create'

  get 'groups/update'

  get 'groups/destroy'

  # collection(集合)はidなし、member(個別)はidあり

  root :to => 'tasks#index'
  get "signup" => "users#new"
  get "admin/users" => "users#index"
  resources :users, :except => :index
  resources :labels
  resources :groups
  resources :calendar

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
      # get :download
    end
  end

  get '*path', to: 'application#render_404'
  post '*not_found' => 'application#routing_error'
  get  '*unmatched_route' => 'application#routing_error', format: false

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
