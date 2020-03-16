class CityTempDatesController < ApplicationController
  before_action :set_city_temp_date, only: [:show, :edit, :update, :destroy]

  # GET /city_temp_dates
  # GET /city_temp_dates.json
  def index
    @city_temp_dates = CityTempDate.all
  end

  # GET /city_temp_dates/1
  # GET /city_temp_dates/1.json
  def show
  end

  # GET /city_temp_dates/new
  def new
    @city_temp_date = CityTempDate.new
  end

  # GET /city_temp_dates/1/edit
  def edit
  end

  # POST /city_temp_dates
  # POST /city_temp_dates.json
  def create
    @city_temp_date = CityTempDate.new(city_temp_date_params)

    respond_to do |format|
      if @city_temp_date.save
        format.html { redirect_to @city_temp_date, notice: 'City temp date was successfully created.' }
        format.json { render :show, status: :created, location: @city_temp_date }
      else
        format.html { render :new }
        format.json { render json: @city_temp_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_temp_dates/1
  # PATCH/PUT /city_temp_dates/1.json
  def update
    respond_to do |format|
      if @city_temp_date.update(city_temp_date_params)
        format.html { redirect_to @city_temp_date, notice: 'City temp date was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_temp_date }
      else
        format.html { render :edit }
        format.json { render json: @city_temp_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_temp_dates/1
  # DELETE /city_temp_dates/1.json
  def destroy
    @city_temp_date.destroy
    respond_to do |format|
      format.html { redirect_to city_temp_dates_url, notice: 'City temp date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_temp_date
      @city_temp_date = CityTempDate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def city_temp_date_params
      params.require(:city_temp_date).permit(:date, :city_id, :temp_id)
    end
end
