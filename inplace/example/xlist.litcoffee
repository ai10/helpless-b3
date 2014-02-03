example list
===

     xList = @xList = new Meteor.Collection null


     Template.xlist.rendered = ->
         console.log 'xlist', this

     Template.xlist.items = ->
         xList.find({}).fetch()

