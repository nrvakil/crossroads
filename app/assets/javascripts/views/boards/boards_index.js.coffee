class Crossroads.Views.BoardsIndex extends Backbone.View

  template: JST['boards/index']
  roll_template: JST['boards/roll']

  events:
    "click #btn-roll": "roll"

  render: ->
    $(@el).html((@template()))
    @face = 'X'
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

