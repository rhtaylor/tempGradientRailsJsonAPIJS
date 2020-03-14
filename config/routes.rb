Rails.application.routes.draw do
  resources :city_temp_date_joins
  resources :temps
  resources :cities
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
