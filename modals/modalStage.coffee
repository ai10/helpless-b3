Template.modalStage.created = ->
    console.log 'createStage', @

Template.modalStage.rendered = ->
    console.log 'renderStage', @
    modalWidth = $('.modal-body').width()

Template.modalStage.showModal = ->
    m = Modals.findOne()
    if m?
        #$(document.body).addClass('modal-open')
        true
    else
        #$(document.body).removeClass('modal-open')
        false

Template.modalStage.modals = ->
    m = Modals.findOne()
    [m]

Template.modalInstance.rendered = ->
    console.log 'Modal Instance', @

Template.modalInstance.height = ->
    hh = 0.82*$(window).height()

Template.modalInstance.width = ->
    ww = 0.74*$(window).width()
    width = switch
        when ww > 760 then 760
        else ww


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


