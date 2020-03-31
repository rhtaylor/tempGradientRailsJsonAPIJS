class Temp < ApplicationRecord
  belongs_to :city 

  def human_readable_sunset 
    Time.at(self.sunset)
  end 
  def temp_diff 
    self.temp_high - self.temp_low
  end  

  def self.calculate_city_temp_drop
      @cities = City.all 
      @temps = @cities.map{ |city| city.temps }   
      #=> overnight temp records  
      @overnight = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '24 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' ").last(5);  

      #=> @afternoon temp records
      @afternoon = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '0 hour' ").last(5);  

      @master_array = [] 

     
    #=> creating out of the instances of Temp for use
      @afternoon.map do |temp2| 
         
        data_afternoon_obj = {} 
        data_afternoon_obj["city_id"] = temp2.city_id
        data_afternoon_obj["temp_city" ] = temp2.city.name 
        data_afternoon_obj["created_at"] = temp2.created_at 
        data_afternoon_obj["current_temp"] = temp2.current_temp 
        data_afternoon_obj["temp_high"] = temp2.temp_high  
        @master_array.push(data_afternoon_obj)
      end
         
        @overnight.map do |temp| 
        data_night_obj = {}  
         data_night_obj["city_id"] = temp.city_id
         data_night_obj["temp_city" ] = temp.city.name 
        data_night_obj["created_at"] = temp.created_at 
        data_night_obj["current_temp"] = temp.current_temp 
        data_night_obj["temp_high"] = temp.temp_high 
        @master_array.push(data_night_obj)
      end 
      #=>sorting the hashes by city
      @abc = @master_array.sort{ |a,b| a["temp_city"][0] <=> b["temp_city"][0] }  
     
      @data_array = [] 
          #=> this will be BigO^2 I don't know another way to do it
          #=> I determine which record is night based on the time created then find the slope
      @abc.map do |objectday| 
        @abc.map do |objectnight|  
          #objectday and objectnight are criss crossing and mixing up. 
          if objectday["temp_city"] === objectnight["temp_city"]  && (objectday["created_at"] - objectnight["created_at"] < 0 ) 
           
            data_obj = {}
            data_obj["city"] = objectday["temp_city"] 
            data_obj["city_id"] = objectday["city_id"]
            time =  objectday["created_at"] - objectnight["created_at"]   
            data_obj["time_change"] = (time/ 3600)
            temp_change = objectnight["current_temp"] - objectday["current_temp"]  
            
            #=> this is degrees/hr 
            data_obj["slope"] 
            inverted_time = (-1 * time)/ 3600
            slope = temp_change / inverted_time
            data_obj["slope"] = slope    
          
   x = GlobalWarming.new(city_id: objectday["city_id"], city: objectday["temp_city"], time_change: time, slope: slope)
            
    @data_array.push(data_obj); 
          end
    city = City.where(name: objectday["temp_city"])  
    slope = 0.00777   
   x = GlobalWarming.new(city_id: objectday["city_id"], city: city[0], slope: slope)
         
        end
        
      end 
    
    
      return @master_array
    end


end
