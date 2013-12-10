Template.modalStage.created = ->
    console.log 'createStage', @

Template.modalStage.rendered = ->
    console.log 'renderStage', @
    modalWidth = $('.modal-body').width()

Template.modalStage.showModal = ->
    m = Modals.findOne()
    if m?
        true
    else
        false

Template.modalStage.modals = ->
    m = Modals.findOne()
    [m]

Template.modalInstance.rendered = ->
    console.log 'Modal Instance', @

Template.modalInstance.height = ->
    0.85*$(window).height()

Template.modalInstance.width = ->
    0.85*$(window).width()

Template.modalInstance.top = ->
    nav = $('div.navbar').height()
    nav-25

Template.modalInstance.isSequence = ->
    console.log 'isSequence', @isSequence
    @isSequence

Template.modalInstance.events
    'click button.close': ->
        Modals.remove @_id

    'click div.modal-backdrop': ->
        id = $('div.modal').attr 'id'
        Modals.remove id


Template.modalInstance.isTemplate = (type)->
    console.log 'isTemplate', type, @
    if @template is type then return true
    false


