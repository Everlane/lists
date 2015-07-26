class App.views.ItemView extends Backbone.View
  className: 'item'
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))
    @displayChildren = true
    @hasChildren = false
    @hasChildren = true if @children.length > 0
    @$el.data('id', @item.id)
    @$el.attr('id', @item.id)

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
    childrenListView = new App.views.ListView(items: @children, parent: @item.id)
    @$el.append(childrenListView.render().el)

  defineToggleSwitch: ->
    @toggleSwitch = "[-]" if @displayChildren
    @toggleSwitch = "[+]" if !@displayChildren

  render: ->
    @defineToggleSwitch()
    content = @template({
      item: @item.toJSON(),
      hasChildren: @hasChildren,
      toggleSwitch: @toggleSwitch
    })
    @$el.html(content)
    @showChildren() if @displayChildren
    @setChanges()
    this

  setChanges: ->
    item = @item
    $(@$el.find('h2.editable')[0]).focusout (e) ->
      title = $(e.currentTarget).find('input').val();
      item.set({title: title})

    $(@$el.find('p.editable')[0]).focusout (e) ->
      content = $(e.currentTarget).find('input').val();
      item.set({content: content})
