require 'shared_methods'

class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  include SharedMethods

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @opponent = @player.player
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def resign_current_player

    current_user.active_player.resign
    render nothing: true
  end

  def handle_correct_response

    current_user.update_question_statistics
    current_user.active_player.respond_correctly
    render nothing: true
  end

  def handle_incorrect_response

    current_user.active_player.respond_incorrectly
    render nothing: true
  end

  def reset_question_properties

    current_user.active_player.finish_question
    render nothing: true
  end

  def set_category_by_id

      current_user.active_player.current_category = Category.find(params[:category_id])
      render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:meter)
    end
end
