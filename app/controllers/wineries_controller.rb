class WineriesController < ApplicationController
  before_action :set_winery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /wineries
  # GET /wineries.json
  def index
    @active_wineries = Winery.active
    @retired_wineries = Winery.retired
    @top_wineries = Winery.top(3)
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
    if current_user.admin
      @winery.destroy
      respond_to do |format|
        format.html { redirect_to wineries_url, notice: 'Winery was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to winery_url, notice: 'You do not have sufficient rights.'
    end
  end

  def toggle_activity
    winery = Winery.find(params[:id])
    winery.update_attribute :active, !winery.active

    new_status = winery.active? ? "active" : "retired"

    redirect_to winery, notice: "winery activity status changed to #{new_status}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_winery
    @winery = Winery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def winery_params
    params.require(:winery).permit(:name, :year, :active)
  end
end
