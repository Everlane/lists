class App.views.LayoutView extends Backbone.View
  initialize: (opts) ->
    @items = new App.collections.Items(opts.data)
    @render()

  render: ->
    @$el.html HandlebarsTemplates['layout']()
    listView = new App.views.ItemListView(collection: @items)
    @$el.append listView.render().el
