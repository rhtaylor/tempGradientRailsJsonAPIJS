Rails.application.routes.draw do  
  resources :temps
  resources :cities 
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
