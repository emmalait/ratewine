class WineClubsController < ApplicationController
  before_action :set_wine_club, only: [:show, :edit, :update, :destroy]

  # GET /wine_clubs
  # GET /wine_clubs.json
  def index
    @wine_clubs = WineClub.all
  end

  # GET /wine_clubs/1
  # GET /wine_clubs/1.json
  def show
    @memberships = Membership.find(params[:id])
  end

  # GET /wine_clubs/new
  def new
    @wine_club = WineClub.new
  end

  # GET /wine_clubs/1/edit
  def edit
  end

  # POST /wine_clubs
  # POST /wine_clubs.json
  def create
    @wine_club = WineClub.new(wine_club_params)

    respond_to do |format|
      if @wine_club.save
        format.html { redirect_to @wine_club, notice: 'Wine club was successfully created.' }
        format.json { render :show, status: :created, location: @wine_club }
      else
        format.html { render :new }
        format.json { render json: @wine_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wine_clubs/1
  # PATCH/PUT /wine_clubs/1.json
  def update
    respond_to do |format|
      if @wine_club.update(wine_club_params)
        format.html { redirect_to @wine_club, notice: 'Wine club was successfully updated.' }
        format.json { render :show, status: :ok, location: @wine_club }
      else
        format.html { render :edit }
        format.json { render json: @wine_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wine_clubs/1
  # DELETE /wine_clubs/1.json
  def destroy
    @wine_club.destroy
    respond_to do |format|
      format.html { redirect_to wine_clubs_url, notice: 'Wine club was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wine_club
    @wine_club = WineClub.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wine_club_params
    params.require(:wine_club).permit(:name, :founded, :city)
  end
end
