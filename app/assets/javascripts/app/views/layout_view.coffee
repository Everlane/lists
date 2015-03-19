#= require app/views/item_creation_form_view

###
This class is the root view layer of the items page. It takes some data (a list
of items), creates a root ItemListView for them, and displays it.

This view is also responsible for the "SAVE" button functionality.
###
class App.views.LayoutView extends Backbone.View
  events:
    'click .save-button': 'saveAllItems'
    'click .new-item': 'addFormView'

  initialize: (opts) ->
    @items = new App.collections.Items(opts.data)
    @render()

    Backbone.Events.bind 'newItemAdded', (item) =>
      @items.add item
      @render()

  saveAllItems: () ->
    Backbone.Events.trigger('saveAllItems')

  addFormView: (e) ->
    formView = new App.views.ItemCreationFormView
    @$('.form-container').html formView.render().el

  render: ->
    @$el.html HandlebarsTemplates['layout']()
    listView = new App.views.ItemListView(collection: @items)
    @$el.append listView.render().el
