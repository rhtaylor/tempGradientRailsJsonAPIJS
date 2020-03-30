class GlobalWarming < ApplicationRecord
  belongs_to :city 
  attr_accessor :city_id, :city, :time_change, :slope
end
