Template.modalStage.created = ->

Template.modalStage.rendered = ->
    Session.set('modalSecond', 0)

Template.modalStage.modals = ->
    m = Modals.findOne()
    [m]

Template.modalStage.events(
    'click div.modal-header': ->
        Modals.remove(@_id)
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


