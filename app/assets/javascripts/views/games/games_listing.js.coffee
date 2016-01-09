class Crossroads.Views.GamesListing extends Backbone.View

  template: JST['games/listing']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html((@template(games: @collection)))
    this
