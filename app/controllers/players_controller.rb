class PlayersController < ApplicationController
  #
  # List all players
  #
  # @return [hash] hash containing all players and total count
  def index
    @players = params[:ids] ? Player.find(params[:ids]) : Player.all
    render json: { payload: @players,
                   meta: { total: @players.count } }
  end
end
