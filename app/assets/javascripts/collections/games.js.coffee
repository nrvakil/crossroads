class Crossroads.Collections.Games extends Backbone.Collection
  model: Crossroads.Models.Game

  url: '/games'

  parse: (options) ->
    this.reset(options.payload)
