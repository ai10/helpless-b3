Template.dynaSign.created = ->
    console.log 'dynaSign created'
    Session.set 'dynaUserFound', false
    Session.set 'dynaUserAuthenticated', false
    Session.set 'dynaEmailValid', false

Template.dynaSign.destroyed = ->
    'dynaSign destroyed'

Template.dynaSign.rendered = ->
    f = @firstNode
    $(f)?.parsley('destroy')?.parsley b3.parsley

Template.dynaSign.helpers
    signedInAs: ->
        Meteor.user().username ?
        (Meteor.user().profile?.name ?
        (Meteor.user().emails[0]?.address ? "Logged In"))

    identityHidden: ->
        if Session.get 'dynaUserFound' then return 'hidden'
        else
            return ""
    passwordHidden: ->
        if not Session.get 'dynaUserFound' then return 'hidden'
        else
            return ""
    signUpHidden: ->
        console.log 'signup helper'
        if Session.get 'dynaEmailValid'
            console.log 'validsignup'
            if not Session.get 'dynaUserExisting'
                console.log 'user not existing.'
                return ""
            else
                return 'hidden'

        "hidden"
    signInHidden: ->
        return "hidden"

Template.dynaSign.events
    'keyup input#emailInput': b3.accountEvents.inputEmail
    'click button#signUp': b3.accountEvents.signUp
