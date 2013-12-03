b3 = @b3

#rendering
Template.modalStage.height = ->
    0.85*$(window).height()

Template.modalStage.width = ->
    0.85*$(window).width()

Template.videoModal.rendered = ->
    return true

