#= require app/collections/items

###
This class is responsible for displaying a single item. Items may or may not
have child items. If our item does have children, we put them in an ItemListView.

ItemViews can collapse (stop displaying) their children.
###
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

    Backbone.Events.bind 'itemChangedPosition', () =>
      @model.set
        position:  @$el.index()
        parent_id: @$el.parents('.item').data('id') || 0

  renderChildren: () ->
    childView = new App.views.ItemListView(collection: @children)
    @$el.append(childView.render().el)

  toggleChildren: () ->
    @state.collapsed = !@state.collapsed
    @render()

  updateTitle: (e) ->
    title = $(e.currentTarget)
    # Careful! The title that was edited might be the title of one of my children
    if title.parent().data('id') == @model.get('id')
      @model.set('title', title.text())

  updateContent: (e) ->
    content = $(e.currentTarget)
    # Same as above
    if content.parent().data('id') == @model.get('id')
      @model.set('content', content.text())

  render: ->
    @$el.html @template(@model.attributes)
    # As much as I hate doing this, it's necessary for drag and drop.
    @$el.attr "data-id", @model.get('id')
    @renderChildren() unless @state.collapsed
    this
