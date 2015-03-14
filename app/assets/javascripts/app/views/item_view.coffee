class App.views.ItemView extends Backbone.View
  initialize: (item) ->
    @item = item

  appendChildren: () ->
    for child in @item.children
      childView = new App.views.ItemView(child)
      @$el = childView.render().el

  render: ->
    @el = HandlebarsTemplates['item'](@item)
    @appendChildren()
    this
