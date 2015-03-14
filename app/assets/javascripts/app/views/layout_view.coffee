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
