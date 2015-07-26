class App.views.ListView extends Backbone.View
  className: 'list'
  tagName: 'ol'

  initialize: (options) ->
    @items = options.items
    @parent = options.parent
    @$el.attr('id', @parent)
    @$el.data('parent-id', @parent)


  render: ->
    @items.each (item) =>
      view = new App.views.ItemView(item: item)
      @$el.append view.render().el


    @$el.sortable
      handle: '.handle'
      connectWith: '.' + @className
      placeholder: 'placeholder-bg'
      stop: (event, ui) ->
        movedId = ui.item.data('id')
        parentId = ui.item.parent().data('parent-id')
        endingPosition = ui.item.index()
        siblings = $(ui.item.parent()).find('li')
        sibs = []

        siblings.each (idx, item) ->
          sibs.push($(item).data('id'))

        i = 0
        sibs.forEach (el) ->
          current = new App.models.Item({id: el})
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
    this
