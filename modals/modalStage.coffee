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
    hh = $(window).height()
    0.9*hh

Template.modalInstance.width = ->
    ww = $(window).width()
    width = switch
        when ww > 800 then 800
        else ww


Template.modalInstance.top = ->
    nav = $('div.navbar').height()
    nav-25

Template.modalInstance.isSequence = ->
    @isSequence

Template.modalInstance.navPills = ->
    @navPills

Template.modalInstance.sequenceItems = ->
    lrs.questions.find { module: @parent }, { sort: { number: 1 }}

Template.modalStage.events
    'click div.modal': ->
        id = $('div.modal').attr 'id'
        Modals.remove id

    'click div.modal-content': (e, t)->
        e.stopPropagation()


Template.modalInstance.events
    'click button.close': ->
        Modals.remove @_id

    'click li.question': (e, t)->
        e.preventDefault()
        number = @number - 1
        b3.toModal number

Template.modalInstance.active = ->
    if @number is (b3.modalSequenceStep + 1) then return "active"
    ""

Template.modalInstance.isTemplate = (type)->
    if @template is type then return true
    false


