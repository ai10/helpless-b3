Template.modalStage.created = ->
    console.log 'modalStage created', @

Template.modalStage.rendered = ->
    console.log 'modalStage rendered', @
    Session.set('modalSecond', 0)

Template.modalStage.modals = ->
    console.log 'MS modals', @
    m = Modals.findOne()
    console.log m
    [m]

Template.modalStage.events(
    'click button.close': ->
        Modals.remove(@_id)
)

Template.modalStage.showModal = ->
    console.log 'showmodal'
    m = Modals.findOne()
    if m?
        console.log 'true'
        true
    else
        console.log 'false'
        false

Template.modalStage.isTemplate = (type)->
    console.log ' isTemplate', type, @
    if @template is type then return true
    false


