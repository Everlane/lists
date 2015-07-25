class App.views.ListView extends Backbone.View
  initialize: (options) ->
    @items = options.items

  render: ->
    @items.each (item) =>
      view = new App.views.ItemView(item: item)
      @$el.append view.render().el
    return this
