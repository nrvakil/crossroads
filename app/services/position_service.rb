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
    @face = params[:face]
    next_coordinates
  end

  attr_reader :params
  attr_accessor :game_id, :player_id, :x, :y, :face, :curr_pos, :direction

  #
  # Initializes the next step to be taken
  #
  # @return [nil]
  def next_coordinates
    get_direction
    current_position
    next_step
  end

  #
  # Converts face value of dice to 2D coordinate system
  #
  # @return [hash] hash containing x and y values for the given face
  def get_direction
    case face
    when 'N'
      @direction = { x: 0, y: 1 }
    when 'E'
      @direction = { x: 1, y: 0 }
    when 'W'
      @direction = { x: -1, y: 0 }
    when 'S'
      @direction = { x: 0, y: -1 }
    end
  end

  #
  # Provides the current position of a player
  #
  # @return [hash] contains x and y coordinates of a player's current location
  def current_position
    @curr_pos = Position.where(game_id: game_id, player_id: player_id)
                .order(created_at: :desc).first

    curr_pos ? curr_pos.as_json(only: [:x, :y]).symbolize_keys : origin
  end

  #
  # Create next position based on the current roll
  #
  # @return [Object] Position object
  def take_a_step
    Position.create!(game_id: game_id, player_id: player_id,
                     face: face, x: x, y: y)
  end

  #
  # Sets winner if another player has passed the point
  #
  # @return [boolean] true if winner else false
  def winner?
    covered = Position.where(game_id: game_id, x: x, y: y)
              .where.not(player_id: player_id).count > 1

    GameService.new(game_id: game_id, player_id: player_id).add_winner if covered
    covered
  end

  private

  #
  # Origin
  #
  # @return [hash] coordinates for the origin
  def origin
    { x: 0, y: 0 }
  end

  #
  # Sets next step
  #
  # @return [nil]
  def next_step
    @x = curr_pos[:x] + direction[:x]
    @y = curr_pos[:y] + direction[:y]
  end
end
