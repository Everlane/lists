class App.views.ListView extends Backbone.View
  className: 'list'
  tagName: 'ol'

  initialize: (options) ->
    @items = options.items
    @parent = options.parent
    @$el.data('parent-id', @parent)

  handleToggleButton: (
    parentId, originalParentId, siblings, endingPosition) ->

    # ensure that the new parent's toggle-children button displays
    $($('#' + parentId).find('.toggle-children')[0]).show()

    # if the original parent doesn't have children anymore, hide its
    # toggle-children button
    if $('#' + originalParentId).find('ol li').length == 0
      $($('#' + originalParentId).find('.toggle-children')[0]).hide()

  # sets the new positions and parent. It's important to go through all
  # sibling elements to ensure their positions never overlap in case of
  # multiple insertions into the same list index
  handleNewPositions: (siblings, endingPosition, parentId, movedId) ->
    i = 0
    siblings.each (idx, item) ->
      itemID = $(item).attr('id')
      current = new App.models.Item({id: itemID})
      if i < endingPosition
        current.set({position: i})
      else if i > endingPosition
        current.set({position: i + 1})
      i += 1

    model = new App.models.Item({id: movedId})
    model.set({
      position: endingPosition,
      parent_id: parentId
    })

  addSortable: ->
    that = this
    @$el.sortable
      handle: '.handle'
      connectWith: '.' + @className
      placeholder: 'placeholder-bg'
      stop: (event, ui) ->
        movedId = ui.item.attr('id')
        parentId = ui.item.parent().data('parent-id')
        endingPosition = ui.item.index()
        siblings = $(ui.item.parent()).find('li')
        originalParentId = $(event.target).parent().attr('id')
        that.handleToggleButton(
          parentId, originalParentId, siblings, endingPosition)
        that.handleNewPositions(
          siblings, endingPosition, parentId, movedId)

  render: ->
    @items.each (item) =>
      view = new App.views.ItemView(item: item)
      @$el.append view.render().el
    @addSortable()
    this
