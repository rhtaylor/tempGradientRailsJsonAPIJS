class WarmingTrackerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city, :time_change, :slope 
    set_id :city_id    
    belongs_to :city
  

end
