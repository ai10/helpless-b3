Template.modalStage.created = ->

Template.modalStage.rendered = ->
    modalWidth = $('.modal-body').width()

Template.modalStage.modals = ->
    m = Modals.findOne()
    [m]

Template.modalStage.height = ->
    height = $(window).height()
    nav = $('div.navbar').height()
    finalH = height-nav
    if finalH > 445 then return 445
    0.85*445

Template.modalStage.width = ->
    width = $(window).width()
    if width > 800 then return 750
    0.85*820

Template.modalStage.top = ->
    nav = $('div.navbar').height()
    nav-25

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


