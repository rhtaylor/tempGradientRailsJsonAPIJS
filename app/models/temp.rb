class Temp < ApplicationRecord
  belongs_to :city 

  def human_readable_sunset 
    Time.at(self.sunset)
  end 
  def temp_diff 
    self.temp_high - self.temp_low
  end  

  def self.overnight 
    @overnight_temps = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '24 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '10 hour' ").take(5); 
  end 
 
  def sunset_hour 
    Time.at(self.sunset).to_s.match(/\d{2}:/)  
  end 

  def self.csv 
    csv = self.overnight.map{ |temp| "#{temp.created_at},  #{temp.temp_high}, #{temp.temp_low}" }
  end  


end
