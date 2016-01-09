class Crossroads.Models.Board extends Backbone.Model

  setBoard: (game_id) ->
    $.board = this

    @game = new Crossroads.Models.Game(id: game_id)
    @game.url = @game.url + '/' + parseInt(game_id)

    response = @game.fetch()

    response.success (options) =>
      @game.set(options.payload)
      $.board.set(game: @game)

      @players = new Crossroads.Collections.Players()
      response = @players.fetch(data: { ids: options.payload.player_ids })

      response.success (options) =>
        @players.reset(options.payload)
        $.board.set(players: @players)

        view = new Crossroads.Views.BoardsIndex()
        $('#main-container').html(view.render().el)
