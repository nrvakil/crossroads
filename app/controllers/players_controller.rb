class PlayersController < ActionController::Base
  def index
    @players = Player.all
    render json: { payload: @players,
                   meta: { total: @players.count } }
  end
end
