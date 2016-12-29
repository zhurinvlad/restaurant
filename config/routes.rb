Rails.application.routes.draw do
  resources :users
  root to: "index#index2"
  # root to: "index#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
