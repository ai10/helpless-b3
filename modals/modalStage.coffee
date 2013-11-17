Template.modalStage.created = ->

Template.modalStage.rendered = ->
    modalWidth = $('.modal-body').width()

Template.modalStage.modals = ->
    console.log 'modals', @
    m = Modals.findOne()
    [m]

Template.modalStage.height = ->
    height = $(window).height()
    nav = $('nav').height()
    finalH = height-nav
    finalH

Template.modalStage.top = ->
    nav = $('div.navbar').height()
    console.log 'nav', nav
    nav

Template.modalStage.events(
    'click button.close': ->
        Modals.remove @_id

    'click div.modal-backdrop': ->
        id = $('div.modal').attr 'id'
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


