class Crossroads.Models.Game extends Backbone.Model

  url: '/games'

  parse: (options) ->
    this.set(options.payload)
