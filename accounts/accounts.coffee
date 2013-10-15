b3.accounts = {
    loginServices: false
    logo: '/images/logo.jpeg'
    askNames: true
    askEmail: true
    dashboard: '/'
}
b3.accountEvents = {}
b3.accountEvents._logIn = (email, password) ->
    console.log 'attempting login', email, password
    Meteor.loginWithPassword email, password, (error)->
        if error?
            console.log 'error', error
            b3.flashError error.reason, { header: 'Login Error:', single: 'dynaPass' }
            Session.set('dynaUserAuthenticated', false)
        else
            b3.flashSuccess email, { header: 'Authenticated:', single: 'dynaPass' }
            Session.set('dynaStep', 0)

b3.accountEvents.inputPassword = (e, t)->
    f = t.firstNode || e.target.f
    console.log 'inputPassword', e.target.value
    valid = $(f).find('input#passwordInput').parsley('validate')
    if valid
        console.log 'valid', e.target.value
        if Session.equals('dynaUserExisting', true)
            email = Session.get 'dynaEmailMaybe'
            console.log 'attempting login', email, e.target.value
            b3.accountEvents._logIn(email, e.target.value)
       else
            console.log 'entering password', e.target.value

    console.log 'invalid password'

b3.accountEvents.checkIdentity = (input) ->
    Meteor.call 'checkIdentity', input.value, (err, result)->
            if result is false
                if input.step is 1
                    Session.set 'dynaUserExisting', false
                    b3.flashInfo input.value, {single: 'dynaUser', header: 'Sign up!'}
            else
                if result?
                    Session.set 'dynaUserExisting', true
                    b3.flashSuccess input.value, { header: 'Welcome back:', single: 'dynaUser' }
                    b3.flashInfo 'Please enter your password.', {single: 'dynaPass' }
                    Session.set 'dynaStep', 3
    false

b3.accountEvents.inputEmail = (e, t) ->
    console.log 'inputIdentity', e.target.value, e.target.value.length
    f = t.firstNode || e.target.f
    valid = $(f).find('input#emailInput').parsley('validate')
    if valid
        console.log 'valid'
        Session.set('dynaEmailValid', true)
        if Session.equals('dynaStep', 1)
            Session.set 'dynaEmailMaybe', e.target.value
            b3.accountEvents.checkIdentity { step: 1, value: e.target.value }
    false

b3.accountEvents.emailReEnter = (e, t) ->
    console.log 'emailReEnter', e.target.value, e.target.value.length
    f = t.firstNode || e.target.form
    valid = $(f).find('input#emailReEnter').parsley('validate')
    if valid
        if  Session.equals('dynaEmailMaybe', e.target.value)
            console.log 'valid reentry', e.target.value
            if Session.equals('dynaStep', 2)
                b3.flashSuccess e.target.value, { header: 'Matched:', single: 'dynaUser' }
                b3.flashInfo 'Please enter a password.', { header: "", single: 'dynaPass' }
                Session.set('dynaStep', 3)
        false

b3.accountEvents.signIn = (e, t)->
    console.log 'signIn', e, t
    hasErrors = false
    e.preventDefault()
    f= t.firstNode.form || e.target.form
    $f = $ f
    if not $f.find('input#passwordInput').parsley('isValid')
        b3.flashError 'Password Invalid.'
        return

    email = Session.get('dynaEmailMaybe')
    password = $f.find('input#passwordInput').val()
    b3.accountEvents._logIn(email, password)
    return false

b3.accountEvents.signUpNew = (e,t) ->
    console.log ' b3 signupi', e, t
    hasError = false
    e.preventDefault()
    f = t.firstNode?.form || e.target?.form
    console.log 'hasError', hasError, f
    $f= $ f
    if Session.equals('dynaStep', 1)
        emailMaybe = $f.find('input#emailInput').val()
        b3.flashInfo emailMaybe, { header: 'Please confirm e-mail:', single: 'dynaUser' }
        Session.set('dynaEmailMaybe', emailMaybe)
        Session.set('dynaStep', 2)
    return false

b3.accountEvents.signUpComplete = (e,t)->
    e.preventDefault()
    console.log 'b3 signupcomplete', e, t
    hasError=false
    f = t.firstNode?.form || e.target.form
    $f = $ f
    valid = $f.find('input#passwordInput').parsley('isValid')
    if valid?
        password = $f.find('input#passwordInput').val()
        email = Session.get('dynaEmailMaybe')
        profile = b3.accounts?.defaultProfile? || {}
        console.log 'epp', password, email, profile
        Accounts.createUser({
            email: email,
            password: password,
            profile: profile
        }, (error)->
            if error?
                console.log error.reason
                b3.flashError error.reason, { single: 'dynaPass' }
            else
                b3.flashSuccess 'Welcome! Thanks for signing up.'
                if b3.accounts?.config?.confirmationEmail
                    b3.flashInfo "A confirmation e-mail should be delivered to #{email} shortly"
                Session.set('dynaStep', 0)
        )

b3.accountEvents.signOut = ->
    console.log 'signout event TODO'

