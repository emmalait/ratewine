class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]
  before_action :set_wineries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :ensure_that_signed_in, except: [:index, :show, :list]

  # GET /wines
  # GET /wines.json
  def index
    @order = params[:order] || 'name'
    return if request.format.html? && fragment_exist?("winelist-#{@order}")

    @wines = Wine.includes(:winery, :style).all

    @wines = case @order
      when 'name' then @wines.sort_by(&:name)
      when 'winery' then @wines.sort_by{ |w| w.winery.name }
      when 'style' then @wines.sort_by{ |w| w.style.name }
    end
  end

  # GET /wines/1
  # GET /wines/1.json
  def show
    @rating = Rating.new
    @rating.wine = @wine
  end

  # GET /wines/new
  def new
    @wine = Wine.new
  end

  # GET /wines/1/edit
  def edit
  end

  # POST /wines
  # POST /wines.json
  def create
    ["winelist-name", "winelist-brewery", "winelist-style"].each{ |f| expire_fragment(f) }
    @wine = Wine.new(wine_params)

    respond_to do |format|
      if @wine.save
        format.html { redirect_to wines_path, notice: 'Wine was successfully created.' }
        format.json { render :show, status: :created, location: @wine }
      else
        set_wineries_and_styles_for_template
        format.html { render :new }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wines/1
  # PATCH/PUT /wines/1.json
  def update
    ["winelist-name", "winelist-brewery", "winelist-style"].each{ |f| expire_fragment(f) }
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: 'Wine was successfully updated.' }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.json
  def destroy
    ["winelist-name", "winelist-brewery", "winelist-style"].each{ |f| expire_fragment(f) }
    if current_user.admin
      @wine.destroy
      respond_to do |format|
        format.html { redirect_to wines_url, notice: 'Wine was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to wine_url, notice: 'You do not have sufficient rights.'
    end
  end

  def list
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wine
    @wine = Wine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wine_params
    params.require(:wine).permit(:name, :style_id, :winery_id)
  end

  def set_wineries_and_styles_for_template
    @wineries = Winery.all
    @styles = Style.all
  end
end
