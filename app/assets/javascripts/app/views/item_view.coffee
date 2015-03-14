#= require app/collections/items

class App.views.ItemView extends Backbone.View
  tagName: 'li'
  className: 'item'
  template: HandlebarsTemplates['item']
  events:
    'click .collapse': 'toggleChildren'
    'input .title':    'updateTitle'
    'input .content':  'updateContent'

  initialize: () ->
    @children = new App.collections.Items(@model.get('children'))
    @state    = collapsed: false

    Backbone.Events.bind 'saveAllItems', =>
      @model.save() if @model.hasChanged()

  renderChildren: () ->
    childView = new App.views.ItemListView(collection: @children)
    @$el.append(childView.render().el)

  toggleChildren: () ->
    @state.collapsed = !@state.collapsed
    @render()

  updateTitle: (e) ->
    text = $(e.currentTarget).text()
    @model.set('title', text)

  updateContent: (e) ->
    text = $(e.currentTarget).text()
    @model.set('content', text)

  render: ->
    @$el.html @template(@model.attributes)
    @renderChildren() unless @state.collapsed or @children.isEmpty()
    this
