Navigation 
====

    
    b3 = @b3

    Template.navigator.clickcounter = 0

    Template.navigator.brand = ->
        b3.brand

    Template.navigator.events
      'click button.logoutBtn' : (e, t) ->
        Meteor.logout()
        Router.go "/"

    Template.navigator.userEmail = () ->
      if Meteor.user()
        Meteor.user().emails[0].address
      else
        "???"

    Template.navigator.registeredCourses = () ->
        u = Meteor.user()
        if u?.profile?.registrations?
            cr = u.profile.registrations
            rx = []
            _.each cr,  (val, key)->
                if val is true
                    rx.push xAPI.activities.findOne({_id: key}, {transform: xAPI.tDefinition})
                true

            return rx

        return null

    Template.navigator.rendered = ->
        console.log 'navigator rendered', @

    Template.navigator.created = () ->

    Template.navigator.destroyed = () ->

