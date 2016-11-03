class Crossroads.Routers.Boards extends Backbone.Router

  routes:
    'board/:game_id': 'index'

  # Setting the board
  index: (game_id) ->
    @board = new Crossroads.Models.Board()
    @board.setBoard(game_id)
