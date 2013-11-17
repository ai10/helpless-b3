Template.modalStage.created = ->

Template.modalStage.rendered = ->
    modalWidth = $('.modal-body').width()

Template.modalStage.modals = ->
    console.log 'modals', @
    m = Modals.findOne()
    [m]

Template.modalStage.height = ->
    console.log 'modal height', @
    405

Template.modalStage.top = ->
    console.log 'modal top', @
    100

Template.modalStage.events(
    'click button.close': ->
        console.log 'modalheader', @
        Modals.remove @_id

    'click div.modal-backdrop': ->
        id = $('div.modal').attr 'id'
        console.log 'modalbackdrop', id
        Modals.remove id
)

Template.modalStage.showModal = ->
    m = Modals.findOne()
    if m?
        true
    else
        false

Template.modalStage.isTemplate = (type)->
    if @template is type then return true
    false


