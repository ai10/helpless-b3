Template.modalPagination.rendered = ->

Template.modalPagination.events
    'click li.nextModal': ->
        b3.nextModal()

    'click li.previousModal': ->
        b3.previousModal()

    'click li.toModal': ->
        b3.toModal()

    'click li.finishSequence': ->
        id = $('div.modal').attr 'id'
        Modals.remove id



