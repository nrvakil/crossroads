class Crossroads.Views.GamesIndex extends Backbone.View

  template: JST['games/index']

  render: ->
    $(@el).html((@template()))
    this
