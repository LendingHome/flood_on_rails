Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing_page#index'
  get '/game', to: 'game#index'
  get '/highscores', to: 'high_scores#index'
  get '*path', to:  'landing_page#index'
  match '/game/update', to: 'game#update', :via => :post
  match '/game/create', to: 'game#create', :via => :post
end
