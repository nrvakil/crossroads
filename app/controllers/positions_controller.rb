class PositionsController < ApplicationController
  #
  # Initiate players and display board
  #
  # @return [hash] hash containing player positions on board
  def index
    @players = Player.all
    render json: { payload: @players,
                   meta: { total: @players.count } }
  end
end
