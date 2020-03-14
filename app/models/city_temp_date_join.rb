class CityTempDateJoin < ApplicationRecord
  belongs_to :city
  belongs_to :temp
end
