class Temp < ApplicationRecord 
    has_many :citytempdates, :class_name => "CityTempDate" 
    has_many :cities, through: :citytempdates
end
