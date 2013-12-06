Template.modalStage.created = ->

Template.modalStage.rendered = ->
    modalWidth = $('.modal-body').width()

Template.modalStage.modals = ->
    m = Modals.findOne()
    [m]

Template.modalStage.height = ->
    0.85*$(window).height()

Template.modalStage.width = ->
    0.85*$(window).width()

Template.modalStage.top = ->
    nav = $('div.navbar').height()
    nav-25

Template.modalStage.events
    'click button.close': ->
        Modals.remove @_id

    'click div.modal-backdrop': ->
        id = $('div.modal').attr 'id'
        Modals.remove id

    'click button.next': ->
        b3.nextModal()

    'click button.previous': ->
        b3.previousModal()


Template.modalStage.showModal = ->
    m = Modals.findOne()
    if m?
        true
    else
        false

Template.modalStage.isTemplate = (type)->
    if @template is type then return true
    false


