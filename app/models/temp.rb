class Temp < ApplicationRecord
  belongs_to :city 

  def dif 
    @overnight_temps = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '24 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '10 hour' ").take(5); 
       
    @high_temps = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '17 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' ").take(5);  
          
  end  
end
