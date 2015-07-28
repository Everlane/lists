class App.views.ItemView extends Backbone.View
  className: 'item'
  tagName: 'li'
  template: HandlebarsTemplates['item']

  initialize: (options) ->
    @item = options.item
    @children = new App.collections.Items(@item.get('children'))
    @$el.data('item-id', @item.id)
    @$el.attr('id', 'item-' + @item.id)
    @showChildren = true

  events:
    'click .toggle-children': 'toggleChildren'
    'click .item-title': 'toggleh2Editable'
    'click .item-content': 'togglepEditable'

  toggleh2Editable: (e) ->
    e.stopPropagation()
    @$el.find('.item-title.uneditable').addClass('hide-edit')
    @$el.find('.item-title.editable').removeClass('hide-edit')

  togglepEditable: (e) ->
    e.stopPropagation()
    @$el.find('.item-content.uneditable').addClass('hide-edit')
    @$el.find('.item-content.editable').removeClass('hide-edit')

  toggleChildren: (e) ->
    e.stopPropagation()
    @showChildren = !@showChildren
    if @showChildren then toggleSwitch = '[-]' else toggleSwitch = '[+]'

    $(e.currentTarget).html(toggleSwitch)
    nextol = $(e.delegateTarget).find('ol').first()
    nextol.toggleClass('hide-children')

  render: ->
    content = @template(item: @item.toJSON())
    @$el.html(content)
    
    childrenListView = new App.views.ListView(
      items: @children,
      parent: @item.id
      )
    @$el.append(childrenListView.render().el)

    if @$el.find('ol li').length == 0
      @$el.find('.toggle-children').hide()

    # add listener for changes in title and content
    item = @item
    @$el.find('h2.editable').first().focusout (e) ->
      title = $(e.currentTarget).find('input').val()
      item.set({title: title})

    @$el.find('p.editable').first().focusout (e) ->
      content = $(e.currentTarget).find('input').val()
      item.set({content: content})
    this
