Rails.application.routes.draw do
  devise_for :users
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  post "/rails/active_storage/direct_uploads", to: "direct_uploads#create"
  root to: 'home#index'
end
