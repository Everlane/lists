#= require app/views/item_view

###
This class is responsible for showing a list of items. Whether items have
children is not the concern of this class. It only knows about what items
should be displayed sequentially.
###
class App.views.ItemListView extends Backbone.View
  tagName: 'ol'
  className: 'item-list'

  render: ->
    @collection.each (item) =>
      view = new App.views.ItemView(model: item)
      @$el.append view.render().el

    @$el.sortable
      update: (e, ui) =>
        @collection.first().set('position', ui.item.index())

    this
