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

  #
  # Checks when to end game
  # Ends for first winner if only two/three players
  # Ends for three winners if more than three players
  #
  # @return [boolean] true if game is to be ended
  def end_game?
    @game = Game.find(game_id)
    count = game.player_ids.count > 3 ? 3 : 1
    @game.winners && @game.winners.count == count ? true : false
  end
end
