class City < ApplicationRecord 
    has_many :citytempdates, :class_name => "CityTempDate"
    has_many :temps, through: :citytempdates
end
