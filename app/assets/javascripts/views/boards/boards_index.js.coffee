class Crossroads.Views.BoardsIndex extends Backbone.View

  template: JST['boards/index']
  roll_template: JST['boards/roll']
  graph_template: JST['boards/graph']
  winner_template: JST['boards/winner']

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
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) =>
          for player_id in @player_ids
            $('#graph').html()
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
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) =>
          position = data.payload
          meta = data.meta
          $('#graph').html($('#graph').html() + (@graph_template(x1: meta.previous_x, y1: meta.previous_y, x2: position.x, y2: position.y, player_id: position.player_id)))

          if meta.winner
            @addWinner(@player_id)

  addWinner: (player_id) ->
    $('#winners').html($('#winners').html() + @winner_template(player_id: @player_id))
