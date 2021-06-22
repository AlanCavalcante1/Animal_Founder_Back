Rails.application.routes.draw do
  post '/sign_up', to: 'authentication#sign_up'
  post '/login', to: 'authentication#login'
  #post '/confirmate'
  post '/authentication/repeat_token', to: "authentication#repeat_validation_token"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
