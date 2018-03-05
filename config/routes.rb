Rails.application.routes.draw do
  resources :task
  root 'task#index'

  # get '/new' => 'task#new'
  #
  # get 'task/show'
  #
  # get 'task/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
