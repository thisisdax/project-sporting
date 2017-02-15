Rails.application.routes.draw do

  resources :followings, only: [:index, :create, :destroy]
  # get 'comments/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  #to ensure that user can only edit own profile - ie. no id param in route
  get 'users/profile/edit', to: "users#edit"
  post 'users/profile/update', to: 'users#update'
  #for image upload
  patch 'users/profile/update_image', to: 'users#update_image'

  resources :events
  resources :event_tags
  get 'events/:id/join', to: 'attendings#redirection'
  post 'events/:id/join', as: 'join_event', to: 'attendings#join'
  delete 'events/:id/leave', as: 'leave_event', to: 'attendings#leave'
  root to: 'events#index'

  resources :events do
    resources :comments
  end
  #contact is just a test controller because cannot render view without it
end
