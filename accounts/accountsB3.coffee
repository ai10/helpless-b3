Meteor.methods(
    'checkIdentity': (email) ->
        console.log 'check identity', email
        if Meteor.isServer
            user = Meteor.users.findOne { 'emails.address': email }
            if user?
                return user
            else
                return false
)

if Meteor.isServer
    Meteor.startup (->
        process.env.MAIL_URL = b3.accounts.config.MAIL_URL
    )
    Accounts.onCreateUser(options, user) ->
        console.log 'onCreateUser', options, user
        if options.profile?
            user.profile = options.profile
        Accounts.sendVerificationEmail(user._id, options.email)
        return user

