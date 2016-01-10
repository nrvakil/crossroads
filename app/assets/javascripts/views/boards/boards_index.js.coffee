class Crossroads.Views.BoardsIndex extends Backbone.View

  template: JST['boards/index']
  roll_template: JST['boards/roll']
  graph_template: JST['boards/graph']
  winner_template: JST['boards/winner']
  log_template: JST['boards/log']

  events:
    "click #btn-roll": "roll"

  render: ->
    @players = new Crossroads.Collections.Players()
    @players.reset($.board.get('players').models)

    $(@el).html((@template(players: @players)))
    @face = 'X'
    @getPosition(@face)
    @roundRobin(@face)
    this

  roll: ->
    url = '/games-roll'
    $.ajax
      url: url
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) =>
        $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) =>
        @face = data.payload
        @roundRobin(@face)
        @getPosition(@face)

  roundRobin: (face) =>
    winners = $.board.game.get('winners') || []

    for winner in winners
      $.board.get('players').remove(id: winner)

    if !$('#player-turn').val()
      @player = $.board.get('players').models[0]
    else
      id = parseInt($('#player-turn').val())
      ids = _.pluck($.board.get('players').models, 'id')
      index = _.indexOf(ids, id) + 1

      if index == ids.length
        index = 0
      @player = $.board.get('players').models[index]

    $('#die-roller').html((@roll_template(face: @face, player: @player)))

  getPosition: (face) =>
    @player_ids = _.pluck($.board.get('players').models, 'id')

    if @face == 'X'
      url = '/positions-initiate'

      $.ajax
        url: url
        type: 'POST'
        dataType: 'json'
        data:
          player_ids: @player_ids
          game_id: $.board.get('game').get('id')
        error: (jqXHR, textStatus, errorThrown) =>
          alert(jqXHR.responseJSON.meta.errors)
          Backbone.history.navigate('listing', true)
        success: (data, textStatus, jqXHR) =>
          console.log('players standing at origin')
    else
      @player_id = parseInt($('#player-turn').val())
      url = '/positions'

      $.ajax
        url: url
        type: 'POST'
        dataType: 'json'
        data:
          player_id: @player_id
          game_id: $.board.get('game').get('id')
          face: @face
        error: (jqXHR, textStatus, errorThrown) =>
          alert(jqXHR.responseJSON.meta.errors)
          Backbone.history.navigate('listing', true)
        success: (data, textStatus, jqXHR) =>
          @position = data.payload
          @meta = data.meta

          $('#name-' + @player.get('id')).remove()
          $('#x-' + @player.get('id')).remove()
          $('#y-' + @player.get('id')).remove()

          row = @graph_template(x1: @meta.previous_x, y1: @meta.previous_y, x2: @position.x, y2: @position.y, player: @player)
          $('#graph').html($('#graph').html() + row)

          if @meta.winner
            @addWinner(@player_id)

          @logEntry(@position, @meta)

          if @meta.end_game
            alert('Game over!')
            Backbone.history.navigate('listing', true)

  addWinner: (player_id) ->
    $.board.game.set({'winners': _.flatten([$.board.game.get('winners'), [player_id]])})

    $('#name-' + @player_id).remove()
    $('#x-' + @player_id).remove()
    $('#y-' + @player_id).remove()

    $('#winners').html($('#winners').html() + @winner_template(player: @player))

  logEntry: (position, meta) ->
    row = @log_template(id: @position.id, name: @player.get('name'), previous_x: @meta.previous_x, previous_y: @meta.previous_y, current_x: @position.x, current_y: @position.y, direction: @position.face, winner: @meta.winner)

    $('#logs').append(row)
