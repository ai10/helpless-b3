Meteor.methods
    'checkIdentity': (email) ->
        if Meteor.isServer
            user = Meteor.users.findOne { 'emails.address': email }
            if user?
                return user
            else
                return false


