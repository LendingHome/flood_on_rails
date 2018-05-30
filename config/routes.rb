Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Index Pages
  get '/', to: 'landing_page#index'
  get '/game', to: 'game#index'
  get '/highscores', to: 'high_scores#index'
  get '/computergame', to: 'computer_game#index'
  
  # Game Routes
  match '/game/update', to: 'game#update', :via => :post
  match '/game/create', to: 'game#create', :via => :post
  match '/computergame/update', to: 'computer_game#update', :via => :post
  match '/computergame/create', to: 'computer_game#create', :via => :post

  # Highscore creation
  post 'highscores' => 'high_scores#create'
  post '/highscores/new', to: 'high_scores#new'

  # User creation
  post 'users' => 'users#create'
  post '/users/new', to: 'users#new'

  # Login, logout
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Catch all
  get '*path', to:  'landing_page#index'
  post '/*', to: 'landing_page#index'
end
