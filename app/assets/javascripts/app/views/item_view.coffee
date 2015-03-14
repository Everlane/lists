#= require app/collections/items

class App.views.ItemView extends Backbone.View
  template: HandlebarsTemplates['item']

  showChildren: () ->
    children  = new App.collections.Items(@model.get('children'))
    childView = new App.views.ItemListView(collection: children)
    console.log(childView.render().el)
    @$el.append(childView.render().el)

  render: ->
    @$el.html @template(@model.attributes)
    @showChildren()
    this
