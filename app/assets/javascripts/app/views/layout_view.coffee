class App.views.LayoutView extends Backbone.View
  template: HandlebarsTemplates['layout']
  
  initialize: (options) ->
    @items = new App.collections.Items(options.data)
    @render()

  render: ->
    @$el.html(@template())
    listView = new App.views.ListView(items: @items)
    @$el.find('.main-list').append listView.render().el
    return this
