class Crossroads.Routers.Games extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    view = new Crossroads.Views.GamesIndex()
    $('#main-container').html(view.render().el)
