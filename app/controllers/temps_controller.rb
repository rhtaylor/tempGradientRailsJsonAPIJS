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
 
  def diff 
      x = Temp.calculate_city_temp_drop 
      render json: x
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
