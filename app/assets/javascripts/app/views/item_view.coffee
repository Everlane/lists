class App.views.ItemView extends Backbone.View
  className: 'item'
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))
    @$el.attr('id', @item.id)
    @displayChildren = true

  events:
    'click .toggle-children': 'toggleChildren'
    'click h2': 'toggleh2Editable'
    'click p': 'togglepEditable'

  toggleh2Editable: (e) ->
    e.stopPropagation()
    $(@$el.find('h2.uneditable')[0]).addClass('hide-edit')
    $(@$el.find('h2.editable')[0]).removeClass('hide-edit')

  togglepEditable: (e) ->
    e.stopPropagation()
    $(@$el.find('p.uneditable')[0]).addClass('hide-edit')
    $(@$el.find('p.editable')[0]).removeClass('hide-edit')

  toggleChildren: (e) ->
    e.stopPropagation()
    @showChildren = !@showChildren
    if @showChildren then toggleSwitch = '[-]' else toggleSwitch = '[+]'

    $(e.currentTarget).html(toggleSwitch)
    nextol = $($(e.delegateTarget).find('ol')[0])
    nextol.toggleClass('hide-children')


  showChildren: () ->
    childrenListView = new App.views.ListView(
      items: @children,
      parent: @item.id
    )
    @$el.append(childrenListView.render().el)

  render: ->
    content = @template({
      item: @item.toJSON()
    })
    @$el.html(content)
    @showChildren()
    @setChanges()

    if @$el.find('ol li').length == 0
      @$el.find('.toggle-children').hide()
    this

  setChanges: ->
    item = @item
    $(@$el.find('h2.editable')[0]).focusout (e) ->
      title = $(e.currentTarget).find('input').val()
      item.set({title: title})

    $(@$el.find('p.editable')[0]).focusout (e) ->
      content = $(e.currentTarget).find('input').val()
      item.set({content: content})
