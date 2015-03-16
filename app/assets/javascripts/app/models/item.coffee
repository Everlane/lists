# This class represents a single item in the database and is responsible for
# maintaining itself accordingly.
class App.models.Item extends Backbone.Model
  urlRoot: "/api/items"

  initialize: ->
    Backbone.Events.bind 'saveAllItems', =>
      @save() if @hasChanged()

    Backbone.Events.bind 'itemChangedPosition', (data) =>
      @set(data) if data.id == @get('id')
