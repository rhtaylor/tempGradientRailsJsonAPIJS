class CityTempDateJoinsController < ApplicationController
  before_action :set_city_temp_date_join, only: [:show, :edit, :update, :destroy]

  # GET /city_temp_date_joins
  # GET /city_temp_date_joins.json
  def index
    @city_temp_date_joins = CityTempDateJoin.all
  end

  # GET /city_temp_date_joins/1
  # GET /city_temp_date_joins/1.json
  def show
  end

  # GET /city_temp_date_joins/new
  def new
    @city_temp_date_join = CityTempDateJoin.new
  end

  # GET /city_temp_date_joins/1/edit
  def edit
  end

  # POST /city_temp_date_joins
  # POST /city_temp_date_joins.json
  def create
    @city_temp_date_join = CityTempDateJoin.new(city_temp_date_join_params)

    respond_to do |format|
      if @city_temp_date_join.save
        format.html { redirect_to @city_temp_date_join, notice: 'City temp date join was successfully created.' }
        format.json { render :show, status: :created, location: @city_temp_date_join }
      else
        format.html { render :new }
        format.json { render json: @city_temp_date_join.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /city_temp_date_joins/1
  # PATCH/PUT /city_temp_date_joins/1.json
  def update
    respond_to do |format|
      if @city_temp_date_join.update(city_temp_date_join_params)
        format.html { redirect_to @city_temp_date_join, notice: 'City temp date join was successfully updated.' }
        format.json { render :show, status: :ok, location: @city_temp_date_join }
      else
        format.html { render :edit }
        format.json { render json: @city_temp_date_join.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /city_temp_date_joins/1
  # DELETE /city_temp_date_joins/1.json
  def destroy
    @city_temp_date_join.destroy
    respond_to do |format|
      format.html { redirect_to city_temp_date_joins_url, notice: 'City temp date join was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_temp_date_join
      @city_temp_date_join = CityTempDateJoin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def city_temp_date_join_params
      params.require(:city_temp_date_join).permit(:day, :city_id, :temp_id)
    end
end
