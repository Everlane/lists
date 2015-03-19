#= require app/views/item_view

###
This class is responsible for showing a list of items. Whether items have
children is not the concern of this class. It only knows about what items
should be displayed sequentially.

This is also the element that is "sortable" - its children (ItemViews) will be
drag-and-droppable and will be reordered accordingly.
###
class App.views.ItemListView extends Backbone.View
  tagName: 'ol'
  className: 'item-list'

  makeMyselfSortable: () ->
    @$el.sortable
      handle: '.handle'              # icon that will be used for dragging
      connectWith: '.' + @className  # class of all other sortable lists
      stop: (e, ui) ->               # triggered whenever something changes
        Backbone.Events.trigger 'itemChangedPosition'

  render: () ->
    @collection.each (item) =>
      view = new App.views.ItemView(model: item)
      @$el.append view.render().el
    @makeMyselfSortable()
    this
