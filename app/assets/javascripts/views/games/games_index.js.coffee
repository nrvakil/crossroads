class Crossroads.Views.GamesIndex extends Backbone.View

  template: JST['games/index']

  events:
    "click #btn-play": "play"

  render: ->
    $(@el).html((@template()))
    this

  play: ->
    Backbone.history.navigate('listing', true)
