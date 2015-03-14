#= require app/collections/items

class App.views.ItemView extends Backbone.View
  template: HandlebarsTemplates['item']
  events:
    'click h2': 'toggleChildren'

  initialize: () ->
    @children = new App.collections.Items(@model.get('children'))
    @state    = collapsed: false

  renderChildren: () ->
    childView = new App.views.ItemListView(collection: @children)
    @$el.append(childView.render().el)

  toggleChildren: () ->
    @state.collapsed = !@state.collapsed
    @render()

  render: ->
    @$el.html @template(@model.attributes)
    @renderChildren() unless @state.collapsed or @children.isEmpty()
    this
