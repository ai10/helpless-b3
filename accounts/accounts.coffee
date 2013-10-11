Router.map ->

  @route "signInPage",
    path: "/sign-in"

  @route "signUpPage",
    path: "/sign-up"

  @route "forgotPassword",
    path: "/forgot-password"

b3.accounts = {
    loginServices: false
    logo: '/images/logo.jpeg'
    askNames: true
    askEmail: true
    dashboard: '/'
}


b3.accountEvents = {}
b3.accountEvents.inputEmail = (e, t) ->
    f = t.firstNode || e.target.f
    console.log 'inputEmail', f
    valid =$(f).find('input#emailInput').parsley('validate')
    if valid
        console.log 'valid', e.target.value
        Session.set 'userEmail', e.target.value

        Session.set 'dynaEmailValid', true
        Meteor.call 'preexistingUser', e.target.value, (err, result)->
            console.log 'preexisting user result', result
            if result is false
                Session.set 'dynaUserExisting', false
                b3.flashInfo ' email not found..,', {single: 'dynaUser', header: 'Sign up!'}
            else
                if result?
                    console.log 'preresult', result
                    firstname = result.profile?.firstname or= 'Back!'
                    Session.set 'dynaUserExisting', true
                    b3.flashSuccess firstname, { header: 'Welcome', single: 'dynaUser' }
                    b3.accounts.preexistingUser = result

    console.log 'invalid email'


b3.accountEvents.signIn = (e, t)->
    console.log 'signIn'
    hasErrors = false
    e.preventDefault()
    f= t.firstNode.form
    $f = $ f
    if not $f.find('input#passwordInput').parsley('isValid')
        b3.flashError 'Password Invalid.'
        hasErrors = true

    if not $f.find('input#emailInput').parsley('isValid')
        b3.flashError 'Email Invalid.'
        hasErrors = true

    if hasErrors
        return

    email = $f.find('input#emailInput').val()
    password = $f.find('input#passwordInput').val()
    email = email.replace /^\s*|\s*$/g, ""
    Meteor.loginWithPassword email, password, (err)->
        if err
            if err.reason is "User not found"
                    Router.go "/sign-in"
            b3.flashError err.reason
            return
        else
            b3.flashSuccess 'Welcome back.'

b3.accountEvents.signUp = (e,t) ->
    console.log ' b3 signupi', e, t
    hasError = false
    e.preventDefault()
    f = t.firstNode?.form || e.target?.form
    console.log 'hasError', hasError, f

    $f= $ f

    if not $f.find('input#passwordInput').parsley('isValid')

        b3.flashError 'Password Invalid'
        hasError = true

    console.log 'password valid', hasError

    if not $f.find('input#emailInput').parsley('isValid')
        b3.flashError 'e-mail is invalid.'
        hasError = true

    console.log 'email valid', hasError

    if not $f.find('input#emailReEnter').parsley('isValid')
        b3.flashError 'e-mails must match.'
        hasError = true

    console.log 'reneter', hasError

    if hasError
        Router.go '/sign-up'
        return
    console.log 'error free'
    password = $f.find('input#passwordInput').val()
    username = $f.find('input#usernameInput').val()
    username = username?.replace? /^\s*|\s*$/g, ""
    email = $f.find('input#emailInput').val()
    email = email?.replace? /^\s*|\s*$/g, ""
    firstname = $f.find('input#firstNameInput').val()
    firstname = firstname?.replace? /^s\*|\s*$/g, ""
    lastname = $f.find('input#lastNameInput').val()
    lastname = lastname?.replace? /^s\*|\s*$/g, ""
    profile = b3.accounts?.defaultProfile? || {}
    _.extend profile, {firstname: firstname, lastname: lastname }
    console.log 'profile'

    Accounts.createUser({
        username: username
        email: email,
        password: password,
        profile: profile
    }, (error)->
        if error?
            console.log error.reason
            b3.flashError error.reason
        else
            b3.flashSuccess 'Welcome! Thanks for signing up.'
            if b3.accounts?.config?.confirmationEmail
                b3.flashInfo "A confirmation e-mail should be delivered to #{email} shortly"
            Router.go b3.accounts.dashboard
    )

b3.accountEvents.signOut = ->
    console.log 'signout event TODO'

