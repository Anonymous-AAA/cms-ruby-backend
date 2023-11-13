# config/routes.rb
Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  post '/signup', to: 'signup#create'
  get '/user/current', to: 'sessions#current'
  post '/complaint', to: 'complaint#create'
  put '/complaint/:id', to: 'complaint#update'
  get '/complaint/:id', to: 'complaint#show'
  delete '/complaint/:id', to: 'complaint#destroy'
  get '/complaints', to: 'complaint#index'


end
