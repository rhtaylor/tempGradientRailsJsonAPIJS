class TempSerializer
  include FastJsonapi::ObjectSerializer 
  set_key_transform :camel
  attributes :temp_high, :temp_mid, :temp_low, :date, :sunset, :created_at  
  set_id :city_id  
  attributes :readableTime do |temp| 
    temp.created_at.hour
  end 
  attributes :day do |temp| 
  temp.created_at.day 
  end 
  attributes :month do |temp| 
    temp.created_at.month 
  end
  attributes :temp_city_name do |temp| 
    temp.city.name 
  end
  belongs_to :city
end
