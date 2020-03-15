class CityTempDate < ApplicationRecord
  belongs_to :cities
  belongs_to :temps
end
