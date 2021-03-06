class CitiesController < ApplicationController
  before_action :set_city, only: [ :show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token  
  def assign_env_variables
    gon.key = ENV["MYAPIKEY"] 
  end

   def index  
     gon.key = ENV["MYAPIKEY"]
   @all = City.all_in_json  
   @alll = City.all
   respond_to do |format|
      format.html { render 'cities/index' }
      format.csv { send_data @alll.to_csv }
      format.json { render json: @alll }
    end
   end  

   def javaScript 
      respond_to do |format|
       format.js { render 'packs/city_mode.js' }
      end
   end


  
  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new 
    @city = City.new(name: params["name"])  
    @city.to_json    
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create 
    binding.pry
    @city = City.new(city_params)
      if @city.save!
         render json: @city 
      else
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def city_params
      params.require(:city).permit(:name, :region, :fetchURL)
    end
end
