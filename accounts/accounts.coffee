b3.accounts = {
    loginServices: false
    logo: '/images/logo.jpeg'
    askNames: true
    askEmail: true
}

Meteor.methods
    'preexistingUser': (email) ->
        check email, String

        if Meteor.isServer
            user = Meteor.users.findOne { emails: {address: email}}
            if user?
                return user
            else
                return false

Router.map ->

  @route "signInPage",
    path: "/sign-in"

  @route "signUpPage",
    path: "/sign-up"

  @route "forgotPassword",
    path: "/forgot-password"

b3.accountEvents = {}
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
    console.log ' b3 signup'
    hasErrors = false
    e.preventDefault()
    f= t.firstNode.form
    $f = $ f
    if not $f.find('input#passwordInput').parsley('isValid')
        b3.flashError 'Password Invalid'
        hasError = true

    if not $f.find('input#emailInput').parsley('isValid')
        b3.flashError 'e-mail is invalid.'
        hasError = true

    if not $f.find('input#emailReEnter').parsley('isValid')
        b3.flashError 'e-mails must match.'
        hasError = true
    if hasErrors
        Router.go '/sign-up'
        return

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
    _.extent profile, {firstname: firstname, lastname: lastname }
    Accounts.createUser({
        username: username
        email: email,
        password: password,
        profile: profile
    }, (error)->
        if error?
            b3.flashError error.reason
        else
            b3.flashSuccess 'Welcome! Thanks for signing up.'
            if b3.accounts?.config?.confirmationEmail
                b3.flashInfo "A confirmation e-mail should be delivered to #{email} shortly"
            Router.go b3.accounts.config.dashboardRoute
    )

b3.formEvent.signOut = ->
    console.log 'signout event TODO'

