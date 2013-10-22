Template.tooltipB3.instances = []
Template.tooltipB3.rendered = ->
    console.log 'ttb3redered', @

Template.tooltipB3.helpers(
    in: ->
        "in"
    id: ->
        "id"
    position: ->
        "position"

    placement: ()->
        ""
)

Template.tooltipB3.created = ()->
    console.log 'ttb3created', @data
    Template.tooltipB3.text = =>
        console.log 'ttText', @, arguments
        @data?.frodo

Template.tooltipB3.destroyed = ->

Template.tooltipB3.events(

)

