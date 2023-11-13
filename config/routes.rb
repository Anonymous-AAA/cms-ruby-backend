# config/routes.rb
Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  post '/signup', to: 'signup#create'
  get '/user/current', to: 'sessions#current'
  post '/complaint', to: 'complaint#create'
  put '/complaint/:id', to: 'complaint#update'
  get '/complaintd/:id', to: 'complaint#destroy'
  get '/complaint/:id', to: 'complaint#show'
  get '/complaints', to: 'complaint#index'
end
