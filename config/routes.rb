Rails.application.routes.draw do 
  resources :city_temp_dates
  resources :temps
  resources :cities
  root "cities#index"
  
  resources :cities do 
    resources :temps 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
