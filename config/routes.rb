Rails.application.routes.draw do
  root to: "tasks#index"
  resources :sessions, only: [:new, :create, :show, :destroy]  
  resources :tasks
  resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy ]

  namespace :admin do
    resources :users, only:[:index, :edit, :update, :new, :create, :show, :destroy]   
  end

end
