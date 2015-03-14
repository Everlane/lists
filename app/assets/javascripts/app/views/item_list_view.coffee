#= require app/views/item_view

class App.views.ItemListView extends Backbone.View
  template: HandlebarsTemplates['item_list']

  render: ->
    @$el.html @template({})
    @collection.each (item) =>
      view = new App.views.ItemView(model: item)
      @$('.main-list').append view.render().el
    this
