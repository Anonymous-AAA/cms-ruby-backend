# config/routes.rb
Rails.application.routes.draw do
  post '/login', to: 'sessions#create'
  post '/signup', to: 'signup#create'
end
