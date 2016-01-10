class PositionsController < ApplicationController
  #
  # Provide covered positions of all players in the game
  #
  # @return [hash] hash containing player positions on board
  def index
    @positions = Position.where(game_id: params[:game_id])
                 .where('player_id IN (?)', params[:player_ids])
                 .order(created_at: :desc).all
    render json: { payload: @positions,
                   meta: { total: @positions.count } }
  end

  #
  # Create starting positions for all players
  #
  # @return [hash] hash containing player positions on board
  def initiate
    @positions = []

    params[:player_ids].each do |player_id|
      @positions << Position.create!(game_id: params[:game_id],
                                     player_id: player_id,
                                     x: 0, y: 0, face: '0')
    end

    render json: { payload: @positions,
                   meta: { total: @positions.count } }
  end

  #
  # Create a position
  #
  # @return [hash] Created position and id
  def create
    service_obj = PositionService.new(params)
    @position = service_obj.take_a_step
    render json: { payload: @position,
                   meta: { id: @position.id,
                           winner: service_obj.winner?,
                           previous_x: service_obj.curr_pos[:x],
                           previous_y: service_obj.curr_pos[:y] } }
  end

  private

  # def position_params
  #   params.permit(:game_id, :player_id, :player_ids, *Position.column_names)
  # end
end
