class WarmingTrackerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city, :time_elapsed, :slope 
    set_id :city_id    
    belongs_to :city 
    set_key_transform :camel
    attributes :slope, :time_elapsed 
    
  attributes :temp_city_name do |temp|  
   city = City.find(temp.city_id) 
   city.name
  end   
   

end
