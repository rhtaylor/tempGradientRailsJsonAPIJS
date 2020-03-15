Rails.application.routes.draw do 
  root "cities#index"
  resources :city_temp_date_joins
  
  resources :cities do 
    resources :temps 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
