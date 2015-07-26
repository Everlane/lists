class App.views.ItemView extends Backbone.View
  className: 'item'
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))
    @displayChildren = true

  events:
    'click .toggle-children': 'toggleChildren'
    'click h2': 'toggleh2Editable'
    'click p': 'togglepEditable'


  toggleh2Editable: (e) ->
    $(@$el.find('h2.uneditable')[0]).addClass('hide-edit')
    $(@$el.find('h2.editable')[0]).removeClass('hide-edit')

  togglepEditable: (e) ->
    $(@$el.find('p.uneditable')[0]).addClass('hide-edit')
    $(@$el.find('p.editable')[0]).removeClass('hide-edit')

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
