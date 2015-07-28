class App.views.ListView extends Backbone.View
  className: 'list'
  tagName: 'ol'

  initialize: (options) ->
    @items = options.items
    @parent = options.parent
    @$el.data('parent-id', @parent)

  handleToggleButton: (
    parentId, originalParentId, siblings, endingPosition) ->

    # Ensure that the new parent's toggle-children button displays.
    $('#item-' + parentId).find('.toggle-children').first().show()

    # If the original parent doesn't have children anymore, hide its
    # toggle-children button.
    if $('#item-' + originalParentId).find('ol li').length == 0
      $('#item-' + originalParentId).find('.toggle-children').first().hide()

  # Sets the new positions and parent. It's important to go through all
  # sibling elements to ensure their positions never overlap in case of
  # multiple insertions into the same list index.
  handleNewPositions: (siblings, endingPosition, parentId, movedId) ->
    siblings.each (idx, item) ->
      itemID = $(item).data('item-id')
      current = new App.models.Item({id: itemID})
      if idx < endingPosition
        current.set({position: idx})
      else if idx > endingPosition
        current.set({position: idx + 1})
      idx += 1

    model = new App.models.Item({id: movedId})
    model.set({
      position: endingPosition,
      parent_id: parentId
    })

  addSortable: ->
    @$el.sortable
      handle: '.handle'
      connectWith: '.' + @className
      placeholder: 'placeholder-bg'
      stop: (event, ui) =>
        movedId = ui.item.data('item-id')
        parentId = ui.item.parent().data('parent-id')
        endingPosition = ui.item.index()
        siblings = $(ui.item.parent()).find('li')
        originalParentId = $(event.target).parent().data('item-id')
        @handleToggleButton(
          parentId, originalParentId, siblings, endingPosition)
        @handleNewPositions(
          siblings, endingPosition, parentId, movedId)

  render: ->
    @items.each (item) =>
      view = new App.views.ItemView(item: item)
      @$el.append view.render().el
    @addSortable()
    this
