Rails.application.routes.draw do
  root 'static_pages#index'
  resources :series, :only => [:index, :show]
  resources :votes, :only => [:index, :create]

  get '/index' => 'series#index'
  
  get '/*path' => 'static_pages#index'
end