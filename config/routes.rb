Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing_page#index'
  get '/game', to: 'game#index'
  get '/highscores', to: 'high_scores#index'
  get '/computergame', to: 'computer_game#index'
  
  match '/game/update', to: 'game#update', :via => :post
  match '/game/create', to: 'game#create', :via => :post
  match '/computergame/update', to: 'computer_game#update', :via => :post
  match '/computergame/create', to: 'computer_game#create', :via => :post
  post 'highscores' => 'high_scores#create'
  post '/highscores/new', to: 'high_scores#new'



  get '*path', to:  'landing_page#index'
end
