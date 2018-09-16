class WineriesController < ApplicationController
  before_action :set_winery, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, only: [:destroy]

  # GET /wineries
  # GET /wineries.json
  def index
    @wineries = Winery.all
  end

  # GET /wineries/1
  # GET /wineries/1.json
  def show
  end

  # GET /wineries/new
  def new
    @winery = Winery.new
  end

  # GET /wineries/1/edit
  def edit
  end

  # POST /wineries
  # POST /wineries.json
  def create
    @winery = Winery.new(winery_params)

    respond_to do |format|
      if @winery.save
        format.html { redirect_to @winery, notice: 'Winery was successfully created.' }
        format.json { render :show, status: :created, location: @winery }
      else
        format.html { render :new }
        format.json { render json: @winery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wineries/1
  # PATCH/PUT /wineries/1.json
  def update
    respond_to do |format|
      if @winery.update(winery_params)
        format.html { redirect_to @winery, notice: 'Winery was successfully updated.' }
        format.json { render :show, status: :ok, location: @winery }
      else
        format.html { render :edit }
        format.json { render json: @winery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wineries/1
  # DELETE /wineries/1.json
  def destroy
    @winery.destroy
    respond_to do |format|
      format.html { redirect_to wineries_url, notice: 'Winery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" and password == "secret"
      end
    end
  


    # Use callbacks to share common setup or constraints between actions.
    def set_winery
      @winery = Winery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def winery_params
      params.require(:winery).permit(:name, :year)
    end
end
