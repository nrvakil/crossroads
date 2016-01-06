class PlayersController < ApplicationController
  def index
    @players = Player.all
    render json: { payload: @players,
                   meta: { total: @players.count } }
  end
end
