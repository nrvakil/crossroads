class Crossroads.Collections.Players extends Backbone.Collection
  model: Crossroads.Models.Player

  url: '/players'

  parse: (options) ->
    this.reset(options.payload)
