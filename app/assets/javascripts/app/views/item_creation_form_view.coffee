#= require app/models/item

class App.views.ItemCreationFormView extends Backbone.View
  tagName: 'form'
  className: 'item-form'
  template: HandlebarsTemplates['item_creation_form']
  events:
    'input .title':   'updateTitle'
    'input .content': 'updateContent'
    'click .save':    'save'
    'click .nevermind': 'remove'

  initialize: () ->
    @model = new App.models.Item
    console.log @model

  updateTitle: (e) ->
    title = $(e.currentTarget).val()
    @model.set('title', title)

  updateContent: (e) ->
    content = $(e.currentTarget).val()
    @model.set('content', content)

  save: (e) ->
    e.preventDefault()
    @model.save().then () =>
      Backbone.Events.trigger 'newItemAdded', @model

  render: () ->
    @$el.html @template({})
    this
