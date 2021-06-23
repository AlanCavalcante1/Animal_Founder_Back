Rails.application.routes.draw do
  resources :animals
  #SignUp and Login
  post '/sign_up', to: 'register#sign_up'
  post '/login', to: 'session#login'

  get '/animals/page/:page', to: 'animals#page'

  #Authentication
  get '/authentication/confirm/:validation_token', to: 'authentication#confirm'
  post '/authentication/repeat_token', to: "authentication#repeat_validation_token"

  #User
  resources :users

  #Password

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
