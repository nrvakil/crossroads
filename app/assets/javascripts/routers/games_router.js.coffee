class Crossroads.Routers.Games extends Backbone.Router
  routes:
    '': 'index'
    'listing': 'listing'

  index: ->
    view = new Crossroads.Views.GamesIndex()
    $('#main-container').html(view.render().el)

  listing: ->
    getter = new Crossroads.Collections.Games()
    response = getter.fetch()

    response.success (options) ->
      @collection = new Crossroads.Collections.Games()
      @collection.reset(options.payload)

      view = new Crossroads.Views.GamesListing(collection: @collection)
      $('#main-container').html(view.render().el)
