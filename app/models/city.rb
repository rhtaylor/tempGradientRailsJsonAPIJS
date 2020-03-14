class City < ApplicationRecord 
    has_many :city_temp_datejoins 
    has_many :temps, through: :city_temp_datejoins
end
