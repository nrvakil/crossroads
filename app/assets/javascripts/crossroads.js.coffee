window.Crossroads =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    new Crossroads.Routers.Games()
    new Crossroads.Routers.Players()
    new Crossroads.Routers.Positions()
    Backbone.history.start()

$(document).ready ->
  Crossroads.initialize()
