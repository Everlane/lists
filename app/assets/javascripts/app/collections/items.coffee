#= require app/models/item

class App.collections.Items extends Backbone.Collection
  url: "/api/items"
  model: App.models.Item
