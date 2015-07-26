class App.models.Item extends Backbone.Model
  urlRoot: "/api/items"

  initialize: ->
    Backbone.Events.bind 'saveChanges', =>
      @save() if @hasChanged()
