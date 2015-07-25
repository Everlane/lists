class App.views.ItemView extends Backbone.View
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))

  render: ->
    @$el.html(@template(item: @item.toJSON()))
    childrenListView = new App.views.ListView(items: @children)
    @$el.append(childrenListView.render().el)
    this
