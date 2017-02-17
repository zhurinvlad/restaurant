Rails.application.routes.draw do
  telegram_webhooks TelegramWebhooksController
  resources :restaurants
  resources :users
  root to: "restaurants#index"
  # root to: "index#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
