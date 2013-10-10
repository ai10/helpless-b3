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
            if not Session.get 'dynaUserAuthenticated'
                console.log 'user not authenticated.'
                return ""

        "hidden"
    signInHidden: ->
        return "hidden"

Template.dynaSign.events
    'keyup input#IdentityInput': (e, t) ->
        f = t.firstNode
        valid =$(f).find('input#IdentityInput').parsley('validate')
        if valid
            console.log 'valid'
            Session.set 'userEmail', e.target.value
            Session.set 'dynaEmailValid', true
            Meteor.call 'preexistingUser', e.target.value, (err, result)->
                console.log 'preexisting user result', result
                if result?
                    Session.set 'dynaUserFound', true
                    b3.flashSuccess 'Welcome Back!'
                    b3.accounts.preexistingUser = result
                else
                    Session.set 'dynaUserFound', false

        else
            console.log 'invalid email'

    'click button#signUp': b3.formEvent.signUp
