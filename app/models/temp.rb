class Temp < ApplicationRecord 
    has_many :city_temp_datejoins 
    has_many :cities, through: :city_temp_datejoins
end
