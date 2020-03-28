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
   binding.pry
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

  
      @overnight_temps = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '24 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '18 hour' ").take(5);  
      @after_sunset = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '8 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '6 hour' ").last(8); 
      @high_temps = Temp.where("created_at BETWEEN 
            date_trunc('day', created_at) + interval '1 day' - interval '12 hour' AND 
            date_trunc('day', created_at) + interval '1 day' - interval '4 hour' ").take(5);  
   #   @created_at = Temp.last.created_at   
       #@test = TempSerializer.new(@high_temps).serialized_json 
      #render json: { OVERNIGHT: @overnight_temps, HOT: @high_temps, TEST: @test, TEST2: @test2}
      #render json: { "AFTER_SET": TempSerializer.new(@after_sunset).serialized_json, "MidnightPlus": TempSerializer.new(@overnight_temps).serialized_json,  "HOTTEST": TempSerializer.new(@high_temps).serialized_json }
      render json: TempSerializer.new(@after_sunset).serialized_json
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
