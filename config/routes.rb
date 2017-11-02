Rails.application.routes.draw do
  post '/graphql', to: 'graphql#query'
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: '/graphql'

  # REST Endpoints
  resources :users
  resources :posts
  resources :photos
  resources :comments
  resources :likes, except: [:show, :update, :edit]
end
