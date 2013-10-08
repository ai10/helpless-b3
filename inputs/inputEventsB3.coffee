
b3.eventHandlers.signIn = (e, t)->
    hasErrors = false
    e.preventDefault()
    f= t.firstNode.form
    $f = $ f
    if not $f.find('#passwordInput').parsley('isValid')
        b3.flashError 'Password Invalid.'
        Session.set 'entryPassword', ""
        hasErrors = true

    if not $f.find('#identityInput').parsley('isValid')
        b3.flashError 'Identity Invalid.'
        Session.set 'entryIdentity', ""
        hasErrors = true

    if hasErrors
        return

    email = $f.find('#identityInput').val()
    password = $f.find('#passwordInput').val()
    email = email.replace /^\s*|\s*$/g, ""
    Meteor.loginWithPassword email, password, (err)->
        if err
            if err.reason is "User not found"
                    Session.set 'b3Identity', email
                    Session.set 'b3Password', password
                    Router.go "/sign-in"
            b3.flashError err.reason
            return
        else
            b3.flashSuccess 'Welcome back.'

b3.eventHandlers.signUp = (e,t) ->
        hasErrors = false
        e.preventDefault()
        f= t.firstNode.form
        $f = $ f
        if not $f.find('#passwordInput').parsley('isValid')
            b3.flashError 'Password Invalid'
            Session.set 'entryPassword', ""
            hasErrors = true

        fields = Accounts.ui._options.passwordSignupFields

        emailRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'EMAIL_ONLY'], fields)

        usernameRequired = _.contains([
            'USERNAME_AND_EMAIL',
            'USERNAME_ONLY'], fields)

        if usernameRequired
            if not $f.find('#usernameInput').parsley('isValid')
                b3.flashError 'Username is invalid.'
                Session.set 'entryUsername', ""
                hasErrors = true

        if emailRequired
            if not $f.find('[data-type="email"]').parsley('isValid')
                b3.flashError 'e-mail is invalid.'
                Session.set 'entryEmail', ""
                hasErrors = true

        if hasErrors
            Router.go '/sign-up'
            return

        password = $f.find('#passwordInput').val()
        Session.set 'entryPassword', password
        username = $f.find('#usernameInput').val()
        username = username?.replace? /^\s*|\s*$/g, ""
        Session.set 'entryUsername', username
        email = $f.find('#emailInput').val()
        email = email?.replace? /^\s*|\s*$/g, ""
        Session.set 'entryEmail', email

        Accounts.createUser({
            username: username,
            email: email,
            password: password,
            profile: AccountsEntry.config.defaultProfile || {}
        }, (error)->
            if error?
                b3.flashError error.reason
            else
                b3.flashSuccess 'Welcome! Thanks for signing up.'
                if AccountsEntry.config.confirmationEmail
                    b3.flashInfo "A confirmation e-mail should be delivered to #{email} shortly"
                Router.go AccountsEntry.config.dashboardRoute
        )


