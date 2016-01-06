Rails.application.routes.draw do
  root to: 'main#index'
  resources :players, only: [:index]
  resources :games, only: [:index, :create]
end
