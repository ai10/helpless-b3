Template.modalClock.timeLeft = ->
    console.log 'answerSeconds'
    s = Session.get('modalSeconds')
    console.log s
    s
Template.modalClock.rendered = -
    console.log 'modalClock rendered'
