Rails.application.routes.draw do
  root to: 'main#index'

  resources :games, only: [:index, :show, :create]
  get '/games-roll' => 'games#roll'

  resources :players, only: [:index]

  resources :positions, only: [:index, :create]
  post '/positions-initiate' => 'positions#initiate'
end
