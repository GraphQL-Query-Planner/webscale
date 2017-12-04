Rails.application.routes.draw do
  post '/graphql', to: 'graphql#query'
  post '/analyze', to: 'graphql#analyze'

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: '/graphql', as: 'graphiql'
  mount GraphiQL::Rails::Engine, at: "/graphiql-analyze", graphql_path: '/analyze', as: 'graphiql-analyze'

  # REST Endpoints
  resources :users
  resources :posts
  resources :photos
  resources :comments
  resources :likes, except: [:show, :update, :edit]
end
