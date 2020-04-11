class City < ApplicationRecord 
    has_many :temps
    #added if user adds city, name can now be pulled out of the fetchURL 
    
    def to_name 
     split =  self.fetchURL.split("q=")
     name = split[1].scan(/(\w+\W\w+,)|(\w+,)/) 
     name[0][0] || name[0][1]
    end 

    def  self.all_in_json 
         @cities = self.all
              @returnValue = @cities.map do |city|  
             if city[:name] === nil 
                city[:name] = city.to_name 
                city.save! 
                city
             else
                city
              end  
              end  
            @returnValue.to_json 
        
    end
end
