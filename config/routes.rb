Rails.application.routes.draw do  
  get 'global_warming/diff'
  resources :temps
  resources :cities  
  get '/packs/city_mode.js', to: 'cities#javaScript' 
  
  get '/cities.json', to: 'cities#index'  
  post '/cities/create', to: 'cities#create' 
  post '/globalwarming', to: 'global_warming#diff'
  get '/globalwarming', to: 'global_warming#diff'
  get "/cities/temps/diff.json", to: 'temps#diff'
  get '/cities/:city_id/temps', to: 'temps#create'
  post '/cities/:city_id/temps', to: 'temps#create' 
  get '/cities/all/pastmidnight', to: 'temps#pastmidnight' 
  get '/cities/:id/pastmidnight', to: 'temps#pastmidnightshow'
  root "cities#index"
  
  resources :cities do 
    resources :temps 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
