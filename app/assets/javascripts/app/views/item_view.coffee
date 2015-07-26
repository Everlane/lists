class App.views.ItemView extends Backbone.View
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))
    @displayChildren = true

  events:
    'click .toggle-children': 'toggleChildren'

  toggleChildren: ->
    @displayChildren = !@displayChildren
    @render()

  showChildren: () ->
    childrenListView = new App.views.ListView(items: @children)
    @$el.append(childrenListView.render().el)

  render: ->
    toggleSwitch = "[-]" if @displayChildren
    toggleSwitch = "[+]" if !@displayChildren
    hasChildren = @children.length

    @$el.html(@template(item: @item.toJSON(), hasChildren: hasChildren, toggleSwitch: toggleSwitch))
    @showChildren() if @displayChildren
    this
