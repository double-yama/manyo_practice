Rails.application.routes.draw do

  # collection(集合)はidなし、member(個別)はidあり

  scope :admin do
    resources :users, :except => [:new, :create, :my_groups] do
      collection do
        get :my_groups
      end
    end
    resources :groups
    resources :labels
  end

  root :to => 'tasks#index'
  get "signup" => "users#new"

  resources :calendar, param: :year_month

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :tasks do
    collection do
      get :my_page
      get :search
      post :turn_complete
    end

    member do
      get :tasks_for_group
      post :read
    end
  end

  get '*path', to: 'application#render_404'
  get '*not_found' => 'application#render_404'
  post '*not_found' => 'application#render_500'
  get  '*unmatched_route' => 'application#render_500', format: false

end
