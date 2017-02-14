Rails.application.routes.draw do
  # get 'comments/create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:edit]
  resources :events
  root to: 'events#index'

  resources :events do
    resources :comments
  end



  #contact is just a test controller because cannot render view without it
end
