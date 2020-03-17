class TempsController < ApplicationController 
  protect_from_forgery unless: -> { request.format.json? }
  before_action :set_temp, only: [:show, :edit, :update, :destroy]


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
    @temp = Temp.new(temp_params)
    binding.pry 
    respond_to do |format|  
      if @temp.new
      format.json { redirect_to action: "create" }
    end
  end
  end

  # POST /temps
  # POST /temps.json
  def create 
    binding.pry
    @temp = Temp.new(temp_params)

    respond_to do |format|
      if @temp.save
        format.html { redirect_to @temp, notice: 'Temp was successfully created.' }
        format.json { render json: @temp, status: :created }
      else
        format.html { render :new }
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

  # GET /temps/1/edit
  def edit
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp
      @temp = Temp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_params
      params.require(:temp).permit(:high, :med, :low)
    end
end
