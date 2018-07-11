Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/scaffolds", to: "scaffolds#index", as: "scaffolds"

  get "/routes", to: "scaffolds#evaluate_routes", as: "routes"

  get "/update", to: "scaffolds#update_data", as: "update"
end
