Rails.application.routes.draw do  
  get '/cities/:city_id/temp', to: 'temps#create'
  post '/cities/:city_id/temp', to: 'temps#create' 

  resources :city_temp_dates
  resources :temps
  resources :cities
  root "cities#index"
  
  resources :cities do 
    resources :temps 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
