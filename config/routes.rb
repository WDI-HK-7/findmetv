Rails.application.routes.draw do
  root 'static_pages#index'
  resources :series, :only => [:index, :show]

  get '/index' => 'series#index'
  
  get '/*path' => 'static_pages#index'
end