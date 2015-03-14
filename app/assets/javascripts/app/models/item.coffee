class App.models.Item extends Backbone.Model
  urlRoot: "/api/items"

  initialize: ->
    Backbone.Events.bind 'saveAllItems', =>
      @save() if @hasChanged()
