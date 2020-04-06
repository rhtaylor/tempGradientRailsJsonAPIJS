class Temp < ApplicationRecord
  belongs_to :city 

  def human_readable_sunset 
    Time.at(self.sunset)
  end 
  def temp_diff 
    self.temp_high - self.temp_low
  end  

  def self.calculate_city_temp_drop 
      
      #Temp.where("created_at::date = ?", "march 1 2020".to_date) 
      #these records are looking good; i only have until 1300 in db so cannot tell after that 
      #created between 12 pm and 4 pm
      @afternoon = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '6 hour'  AND 
            date_trunc('day', created_at) + interval '1 day' + interval '8 hour' ").last(15);   
      #created between 0000 and 3 am
      @overnight = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '19' hour  AND 
            date_trunc('day', created_at) + interval '1 day' - interval '10' hour ").last(15);
     
    @master_array = [] 
    
    
    #=> creating out of the instances of Temp for use 
    #@test is used in place of @afternoon as I have zero records made for the PM shift.  
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
      @abc = @master_array.sort do  |a,b| 
        x = (a["temp_city"][0] <=> b["temp_city"][0])  
          if x.zero?  
            
              (a["created_at"] <=> b["created_at"]) 
          end 
          x
      end
        
     
      @data_array = [] 
          #=> this will be BigO^2 I don't know another way to do it
          #=> I determine which record is night based on the time created then find the slope 
          #=> roger, what do you think I should do here? O^2. I hate it. 
      @abc.map do |objectday| 
        @abc.map do |objectnight|  
          #objectday and objectnight are criss crossing and mixing up.  
          
          if objectday["temp_city"] === objectnight["temp_city"]  && (objectday["created_at"].hour - objectnight["created_at"].hour > 0 ) && (objectday["created_at"].day == objectnight["created_at"].day + 1)
           
            data_obj = {}
            data_obj["city"] = objectday["temp_city"] 
            data_obj["city_id"] = objectday["city_id"]
            time =  objectday["created_at"] - objectnight["created_at"]   
            data_obj["time_change"] = (time/ 360000)
            temp_change = objectnight["current_temp"] - objectday["current_temp"]  
            
            #=> this is degrees/hr 
            data_obj["slope"] 
            inverted_time = (1 * time)/ 3600
            slope = temp_change / inverted_time
            data_obj["slope"] = slope    
            
     
            #for decimal slope call to_s to get the useable number
          record_for_serialization = GlobalWarming.new(city_id: objectday["city_id"], time_elapsed: inverted_time, slope: slope)
            #One thing I will need to do is refactor and save these records
          record_for_serialization.city = objectday["temp_city"] 
         
           
          #line 92 is never used
          json = WarmingTrackerSerializer.new(record_for_serialization).serialized_json 
    @data_array.push({ "city": record_for_serialization.city , "info": record_for_serialization }) 
    #revert back if unserialized data is not different     
    #@data_array.push(json); 
          end
           
        end
        
      end 
    
   
      return @data_array
    end


end
 

   