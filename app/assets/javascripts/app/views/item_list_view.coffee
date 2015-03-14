#= require app/views/item_view

class App.views.ItemListView extends Backbone.View
  tagName: 'ol'
  className: 'item-list'

  render: ->
    @collection.each (item) =>
      view = new App.views.ItemView(model: item)
      @$el.append view.render().el
    this
