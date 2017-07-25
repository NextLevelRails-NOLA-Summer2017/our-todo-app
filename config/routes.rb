Rails.application.routes.draw do

  # get 'tasks' => 'tasks#index'
  # get 'new-task' => 'tasks#new'
  # get 'task' => 'tasks#show'
  # get 'edit-task' => 'tasks#edit'
  # post 'new-task' => 'tasks#create'
  # patch 'edit-task' => 'tasks#update'
  # delete 'task' => 'tasks#destroy'

  resources :tasks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
