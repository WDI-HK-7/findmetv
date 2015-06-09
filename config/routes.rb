Rails.application.routes.draw do
  root 'static_pages#index'
  resources :series, :only => [:index, :show, :update]

  get '/findByName/:name' => 'series#findByName'
  get '/best'  => 'series#best'
  get '/worst' => 'series#worst'
  get '/findByCategory/:category' => 'series#findByCategory'
  
  resources :votes, :only => [:index, :create]

  get '/*path' => 'static_pages#index'
end