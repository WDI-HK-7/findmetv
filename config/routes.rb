Rails.application.routes.draw do
  root 'static_pages#index'
  resources :series, :only => [:index, :show, :update]
  resources :votes, :only => [:index, :create]

  get  '/findByName/:name' => 'series#findByName'
  get  '/best'  => 'series#best'
  get  '/worst' => 'series#worst'
  get  '/findByCategory/:category' => 'series#findByCategory'
  post '/recommend' => 'recommend#series'
  
  get '/*path' => 'static_pages#index'
end