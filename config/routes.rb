Rails.application.routes.draw do
  get 'users/profile/:id' => 'users#show'
  get 'users/profile/:id/edit' => 'users#edit'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_for :users, path: '', path_names: { sign_in: 'signin', sign_out: 'signout' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events

  #contact is just a test controller because cannot render view without it
end
