class Crossroads.Views.GamesListing extends Backbone.View

  template: JST['games/listing']

  initialize: ->
    @collection.on('sync', @loadBoard, this)

  events:
    "click #btn-go": "go"

  render: ->
    $(@el).html((@template(games: @collection)))
    this

  go: ->
    player_count = parseInt($('#player_count').val())
    @curr_game = @collection.create player_count: player_count

  loadBoard: ->
    if @curr_game
      Backbone.history.navigate("board/#{@curr_game.get('id')}", true)
