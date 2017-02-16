Rails.application.routes.draw do

  resources :followings, only: [:index, :create, :destroy]
  # get 'comments/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'users/search', to: "users#index"

  resources :users, only: [:index,:show,:edit]

  #to ensure that user can only edit own profile - ie. no id param in route
  get 'users/profile/edit', to: "users#edit"
  post 'users/profile/update', to: 'users#update'
  #for image upload
  patch 'users/profile/update_image', to: 'users#update_image'
  get 'events/:id/join', to: 'attendings#redirection'
  post 'events/:id/join', as: 'join_event', to: 'attendings#join'
  delete 'events/:id/leave', as: 'leave_event', to: 'attendings#leave'
  get 'events/list', as: 'list_event', to: 'events#list'
  get 'events/list/recommend', as: 'recommend_event', to: 'events#recommend'
  get 'events/list/myevents', as: 'myevents', to: 'events#myevents'
  root to: 'events#index'
  resources :event_tags
  resources :events do
    resources :comments
  end
  #contact is just a test controller because cannot render view without it
end
