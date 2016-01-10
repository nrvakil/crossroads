class GameService
  #
  # Initialise game service object
  # @param params = {} [hash] contains game attributes
  #
  # @return [nil]
  def initialize(params = {})
    @params = params
    @game_id = params[:game_id]
    @player_id = params[:player_id]
  end

  attr_reader :params
  attr_accessor :game_id, :player_id, :game

  #
  # Adds winner for the game
  #
  # @return [array] winners for the game
  def add_winner
    @game = Game.find(game_id)
    game.winners ||= []
    game.winners << player_id
    game.save
    game.winners
  end
end
