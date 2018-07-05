Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/scaffolds", to: "scaffolds#index", as: "scaffolds"
  
end
