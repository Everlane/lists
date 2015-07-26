class App.views.ListView extends Backbone.View
  className: 'list'
  tagName: 'ol'

  initialize: (options) ->
    @items = options.items

  render: ->
    @items.each (item) =>
      view = new App.views.ItemView(item: item)
      @$el.append view.render().el

    @$el.sortable
      handle: '.handle'
      connectWith: '.' + @className
      placeholder: 'placeholder-bg'

    this
