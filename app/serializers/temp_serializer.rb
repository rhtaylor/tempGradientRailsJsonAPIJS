class TempSerializer
  include FastJsonapi::ObjectSerializer 
  set_key_transform :camel
  attributes :temp_high, :temp_mid, :temp_low, :date, :sunset  
  set_id :city_id 
  attributes :temp_city_name do |temp| 
    temp.city.name 
  end
  belongs_to :city
end
