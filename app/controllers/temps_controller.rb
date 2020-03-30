class TempsController < ApplicationController
  before_action :set_temp, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  # GET /temps
  # GET /temps.json
  def index
    @temps = Temp.all
  end

  # GET /temps/1
  # GET /temps/1.json
  def show
  end

  # GET /temps/new
  def new 
    binding.pry
    @temp = Temp.new
  end

  # GET /temps/1/edit
  def edit
  end

  # POST /temps
  # POST /temps.json
  def create 
    
    params["city_id"] = params["id"];  
   
    @temp = Temp.create(temp_params)
   
    respond_to do |format|
      if @temp.save
        
        format.json { render json: @temp, status: :created, location: @temp }
      else
        
        format.json { render json: @temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temps/1
  # PATCH/PUT /temps/1.json
  def update
    respond_to do |format|
      if @temp.update(temp_params)
        format.html { redirect_to @temp, notice: 'Temp was successfully updated.' }
        format.json { render :show, status: :ok, location: @temp }
      else
        format.html { render :edit }
        format.json { render json: @temp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temps/1
  # DELETE /temps/1.json
  def destroy
    @temp.destroy
    respond_to do |format|
      format.html { redirect_to temps_url, notice: 'Temp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  def pastmidnight 
    @temps = Temp.where('EXTRACT(hour FROM created_at) BETWEEN ? AND ?', 0000, 0004)
    render json: @temps  
    
  end 

  def pastmidnightshow 
    @city = City.find(params[:id]) 
    @temps_early = @city.temps.where('EXTRACT(hour FROM created_at) BETWEEN ? AND ?', 0000, 0004).take(3) 
    @temps_hot = @city.temps.order(:temp_high).take(3)
    render json: { early_morning: @temps_early, hot:  @temps_hot} 
  end 

    def diff 
      @cities = City.all 
      @temps = @cities.map{ |city| city.temps }   
      @overnight = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '24 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' ").last(5);  

      #=> @afternoon wins
      @afternoon = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '0 hour' ").last(5);   
       @csv_afternoon = @afternoon.map{ |temp| "Date #{temp.created_at} HoT #{temp.temp_high} NOW #{temp.current_temp}" }     
       @csv_overnight = @overnight.map{ |temp| "Date #{temp.created_at} HoT #{temp.temp_high} NOW #{temp.current_temp}" }
     @master_array = []
    
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
      
      @abc = @master_array.sort{ |a,b| a["temp_city"][0] <=> b["temp_city"][0] }  
     
      @data_array = []
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
            
            @data_array.push(data_obj);
          end 
          
        end
        
      end 
    y =  GlobalWarming.new(city_id: 1, city: "Phoenix",time_change: -100, slope: -5)
    x =  WarmingTrackerSerializer.new(y).serialized_json
    render json: x
      binding.pry
      
     x = @data_array.map{ |hash| GlobalWarming.new(hash) }
      binding.pry
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp
      @temp = Temp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_params
      params.require(:temp).permit(:date, :sunset, :current_temp, :temp_high, :temp_mid, :temp_low, :city_id,:sunset_datetime,:id)
    end
end
