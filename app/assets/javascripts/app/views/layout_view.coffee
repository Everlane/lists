###
This class is the root view layer of the items page. It takes some data (a list
of items), creates a root ItemListView for them, and displays it.

This view is also responsible for the "SAVE" button functionality.
###
class App.views.LayoutView extends Backbone.View
  events:
    'click .save-button': 'saveAllItems'

  saveAllItems: () ->
    Backbone.Events.trigger('saveAllItems')

  initialize: (opts) ->
    @items = new App.collections.Items(opts.data)
    @render()

  render: ->
    @$el.html HandlebarsTemplates['layout']()
    listView = new App.views.ItemListView(collection: @items)
    @$el.append listView.render().el
