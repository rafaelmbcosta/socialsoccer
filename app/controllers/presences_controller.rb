class PresencesController < ApplicationController
  before_action :set_presence, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /presences
  # GET /presences.json
  def index
    @matches = Match.unfinished
  end

  def new_match_presence
    @players = Player.all
    @match = Match.find(params["id"])
  end

  # GET /presences/1
  # GET /presences/1.json
  def show
  end

  # GET /presences/new
  def new
    @presence = Presence.new
  end

  # GET /presences/1/edit
  def edit
  end

  # POST /presences
  # POST /presences.json
  def create
    @presence = Presence.new(presence_params)

    respond_to do |format|
      if @presence.save
        format.html { redirect_to @presence, notice: 'Presence was successfully created.' }
        format.json { render :show, status: :created, location: @presence }
      else
        format.html { render :new }
        format.json { render json: @presence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presences/1
  # PATCH/PUT /presences/1.json
  def update
    respond_to do |format|
      if @presence.update(presence_params)
        format.html { redirect_to @presence, notice: 'Presence was successfully updated.' }
        format.json { render :show, status: :ok, location: @presence }
      else
        format.html { render :edit }
        format.json { render json: @presence.errors, status: :unprocessable_entity }
      end
    end
  end

  def played
    presence = Player.presence(params["player_id"], params["id"] )
    presence.presence =  true
    presence.save
    respond_to do |format|
      format.html { redirect_to new_match_presence_path }
    end
  end

  def payed
    presence = Player.presence(params["player_id"], params["id"] )
    presence.payed =  true
    presence.save
    respond_to do |format|
      format.html { redirect_to new_match_presence_path }
    end
  end

  def team_played
    presence = Player.presence(params["player_id"], params["id"] )
    presence.team_id =  params["team_id"]
    presence.save
    respond_to do |format|
      format.html { redirect_to new_match_presence_path }
    end
  end

  def manage_goals
    #RuntimeError "id"=>"1", "player_id"=>"1", "goals"=>"0", "operation"=>"plus"
    presence = Player.presence(params["player_id"], params["id"] )
    presence.goals = params["goals"].to_i + 1 if params["operation"] == "plus"
    presence.goals = params["goals"].to_i - 1 if params["operation"] == "minus"
    presence.save
    respond_to do |format|
      format.js
    end
  end

  def confirmed
    presence = Player.presence(params["player_id"], params["id"] )
    presence.confirmation = true
    presence.save
    respond_to do |format|
      format.html { redirect_to new_match_presence_path }
    end
  end

  # DELETE /presences/1
  # DELETE /presences/1.json
  def destroy
    @presence.destroy
    respond_to do |format|
      format.html { redirect_to presences_url, notice: 'Presence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presence
      @presence = Presence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presence_params
      params.require(:presence).permit(:player_id, :match_id, :confirmation, :team_id)
    end
end
