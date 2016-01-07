class PositionsController < ApplicationController
  #
  # Provide covered positions of all players in the game
  #
  # @return [hash] hash containing player positions on board
  def index
    @positions = Position.where(game_id: params[:game_id])
                 .in(player_id: params[:player_ids]).order(created_at: :desc).all
    render json: { payload: @positions,
                   meta: { total: @positions.count } }
  end

  private

  def position_params
    params.permit(:game_id, :player_id, :player_ids, *Position.column_names)
  end
end
