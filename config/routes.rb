Rails.application.routes.draw do
  devise_for :users, only: [:sessions]
  resources :users
  resources :tasks do
    member do
      patch :update_task_status
    end
  end
  root 'tasks#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
