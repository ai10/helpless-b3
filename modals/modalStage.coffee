Template.modalStage.created = ->

Template.modalStage.rendered = ->
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
    @isSequence

Template.modalInstance.sequenceItems = ->
    console.log 'sequence items', @
    lrs.questions.find { module: @parent }, { sort: { number: 1 }}

Template.modalInstance.events
    'click button.close': ->
        Modals.remove @_id

    'click div.modal-backdrop': ->
        id = $('div.modal').attr 'id'
        Modals.remove id

    'click li.question': (e, t)->
        e.preventDefault()
        console.log 'question', @
        number = @number - 1
        b3.toModal number

Template.modalInstance.active = ->
    console.log 'b3sqstep', b3.modalSequenceStep
    if @number is (b3.modalSequenceStep + 1) then return "active"
    ""

Template.modalInstance.isTemplate = (type)->
    if @template is type then return true
    false


