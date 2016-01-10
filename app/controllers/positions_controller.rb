class PositionsController < ApplicationController
  before_filter -> { check_game_status }, only: [:initiate, :create]

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
      record_params = { game_id: params[:game_id], player_id: player_id,
                        x: 0, y: 0, face: '0' }
      @positions << Position.create!(record_params) if Position.where(record_params).all.blank?
    end

    render json: { payload: @positions,
                   meta: { total: @positions.count } }
  end

  #
  # Creates a position
  #
  # @return [hash] Created position and id
  def create
    service_obj = PositionService.new(params)
    @position = service_obj.take_a_step

    render json: { payload: @position,
                   meta: { id: @position.id,
                           winner: service_obj.winner?,
                           end_game: check_game_status(false),
                           previous_x: service_obj.curr_pos[:x],
                           previous_y: service_obj.curr_pos[:y] } }
  end

  private

  #
  # Checks if game needs to be ended
  #
  # @return [nil]
  def check_game_status(raise_exception = true)
    service_obj = GameService.new(game_id: params[:game_id])
    end_game = service_obj.end_game?

    return end_game unless raise_exception

    if end_game
      names = Player.where('id IN (?)', service_obj.game.winners)
              .pluck(:name)

      fail GameIsOver.new 'Da! game is over! Winners - ' \
                          "#{names.join(', ')}"
    end
  end
end
