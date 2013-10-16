Template.dynaSign.created = ->
    Session.set 'dynaStep', 1
    Session.set 'dynaUserExisting', false
    Session.set 'dynaUserAuthenticated', false
    Session.set 'dynaEmailMaybe', ""
    Session.set 'dynaEmailValid', false

Template.dynaSign.destroyed = ->
    'dynaSign destroyed'

Template.dynaSign.rendered = ->
    f = @firstNode
    $(f)?.parsley('destroy')?.parsley b3.parsley

Template.dynaSign.helpers
    dynaEmailMaybe: ->
        if Session.equals('dynaEmailValid', true)
            return Session.get('dynaEmailMaybe')
        else
            return ""
    signedInAs: ->
        Meteor.user().username ?
        (Meteor.user().profile?.name ?
        (Meteor.user().emails[0]?.address ? "Logged In"))
    showStep3: ->
        if Session.equals('dynaStep', 3) then return ""
        "hidden"
    showStep2: ->
        if Session.equals('dynaStep', 2) then return ""
        "hidden"
    showStep1: ->
        if Session.equals('dynaStep', 1) then return ""
        "hidden"
    showChangeUser: ->
        if Session.equals('dynaStep', 1) then return "hidden"
        ""
    showComplete: ->
        if Session.equals('dynaStep', 3)
            if Session.equals('dynaUserExisting', false) then return ""
        "hidden"
    showNew: ->
        if Session.equals('dynaStep', 1)
            if Session.equals('dynaEmailValid', true)
                if Session.equals('dynaUserExisting', false) then return ""
        "hidden"
    showSignIn: ->
        if Session.equals('dynaStep', 3)
            if Session.equals('dynaUserExisting', true) then return ""
        "hidden"

Template.dynaSign.events
    'change, keyup input#emailInput': b3.accountEvents.inputEmail
    'change, keyup input#emailReEnter': b3.accountEvents.emailReEnter
    'change, keyup input#passwordInput': b3.accountEvents.inputPassword
    'keydown input': (e, t) ->
        if e.keyCode is 13
            e.preventDefault()
            return
    'click button#signUpNew': b3.accountEvents.signUpNew
    'click button#signUpComplete': b3.accountEvents.signPass
    'click button#signIn': b3.accountEvents.signPass
    'click div#changeUser': ->
        if Meteor.userId()
            Meteor.logout()
        Session.set 'dynaEmailMaybe', ""
        Session.set 'dynaEmailValid', false
        Session.set 'dynaUserExisting', false
        Session.set 'dynaStep', 1
    'click button#forgotPass': ->
        console.log 'forgot pass'
        if Session.equals('dynaUserExisting', true)
            email = Session.get 'dynaEmailMaybe'
            console.log 'forgot password for:', email
            Accounts.forgotPassword { email: email }, (error)->
                if error?
                    console.log 'error:', error
                else
                    console.log 'forgotpassword email success'

