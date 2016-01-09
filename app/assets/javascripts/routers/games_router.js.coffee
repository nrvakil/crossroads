class Crossroads.Routers.Games extends Backbone.Router
  routes:
    '': 'index'
    'listing': 'listing'

  initialize: ->
    @collection = new Crossroads.Collections.Games()
    @collection.fetch()

  index: ->
    view = new Crossroads.Views.GamesIndex()
    $('#main-container').html(view.render().el)

  listing: ->
    view = new Crossroads.Views.GamesListing(collection: @collection)
    $('#main-container').html(view.render().el)
