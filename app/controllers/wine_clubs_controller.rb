class WineClubsController < ApplicationController
  before_action :set_wine_club, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /wine_clubs
  # GET /wine_clubs.json
  def index
    @wine_clubs = WineClub.all

    order = params[:order] || 'name'

    @wine_clubs = case order
      when 'name' then @wine_clubs.sort_by{ |w| w.name }
      when 'year' then @wine_clubs.sort_by{ |w| w.founded }
      when 'city' then @wine_clubs.sort_by{ |w| w.city }
    end
  end

  # GET /wine_clubs/1
  # GET /wine_clubs/1.json
  def show
    @membership = if @wine_club.users.include? current_user
                    @wine_club.memberships.where(user: current_user).first
                  else
                    Membership.new wine_club: @wine_club
                  end
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
    if current_user.admin
      @wine_club.destroy
      respond_to do |format|
        format.html { redirect_to wine_clubs_url, notice: 'Wine club was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to wine_club_url, notice: 'You do not have sufficient rights.'
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
