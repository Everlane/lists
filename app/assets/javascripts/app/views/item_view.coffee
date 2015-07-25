class App.views.ItemView extends Backbone.View
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item

  render: ->
    @$el.html(@template(item: @item.toJSON()))
    this
