class Crossroads.Views.GamesListing extends Backbone.View

  template: JST['games/listing']

  initialize: ->
    @collection.on('sync', @loadBoard, this)

  events:
    "click #btn-go": "go"

  render: ->
    @players = new Crossroads.Collections.Players()
    response = @players.fetch(data: { ids: _.flatten(@collection.pluck('player_ids')) })

    response.success (options) =>
      @players.reset(options.payload)
      $(@el).html((@template(games: @collection, players: @players)))
    this

  go: ->
    player_count = parseInt($('#player_count').val())
    @curr_game = @collection.create player_count: player_count

  loadBoard: ->
    if @curr_game
      Backbone.history.navigate("board/#{@curr_game.get('id')}", true)
