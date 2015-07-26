class App.views.LayoutView extends Backbone.View
  template: HandlebarsTemplates['layout']

  initialize: (options) ->
    @items = new App.collections.Items(options.rootItems)
    @render()

  events:
    'click .save-button': 'saveChanges'

  saveChanges: ->
    Backbone.Events.trigger('saveChanges')

  render: ->
    @$el.html(@template())
    listView = new App.views.ListView(items: @items)
    @$el.find('.main-list').append(listView.render().el)
    return this
