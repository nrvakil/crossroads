class PositionService
  #
  # Initialise position service object
  # @param params = {} [hash] contains position attributes
  #
  # @return [nil]
  def initialize(params = {})
    @params = params
    @game_id = params[:game_id]
    @player_id = params[:player_id]
    @x = params[:x]
    @y = params[:y]
    @face = params[:face]
  end

  attr_reader :params
  attr_accessor :game_id, :player_id, :x, :y, :face

  #
  # Convert face value of direction wrt 2D coordinate system
  #
  # @return [hash] hash containing x and y values for the given face
  def face_value
    case face
    when 'N'
      { x: 0, y: 1 }
    when 'E'
      { x: 1, y: 0 }
    when 'W'
      { x: 0, y: -1 }
    when 'S'
      { x: -1, y: 0 }
    end
  end

  #
  # Provides the current position of a player
  #
  # @return [hash] contains x and y coordinates of a player's current location
  def current_position
    curr_pos = Position.where(game_id: game_id, player_id: player_id)
               .order(created_at: :desc).first

    curr_pos ? curr_pos.as_json(only: [:x, :y]).symbolize_keys : origin
  end

  #
  # Create next position based on the current roll
  #
  # @return [Object] Position object
  def take_a_step
    direction = face_value
    curr_pos = current_position

    Position.create!(game_id: game_id, player_id: player_id, face: face,
                     x: curr_pos[:x] + direction[:x],
                     y: curr_pos[:y] + direction[:y])
  end

  private

  #
  # Origin
  #
  # @return [hash] coordinates for the origin
  def origin
    { x: 0, y: 0 }
  end
end
