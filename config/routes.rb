Rails.application.routes.draw do
  resources :contents
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end