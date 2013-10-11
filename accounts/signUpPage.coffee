
class signUpPageController extends RouteController
    template: 'signUpPage'

Template.signUpPage.rendered = ->
    f = @find('form')
    $(f)?.parsley('destroy')?.parsley b3.parsley

Template.signUpPage.helpers(
    logo: 'logo.jpeg'
    loginServices: b3.accounts?.loginServices or= false
    askNames: b3.accounts?.askNames or= true
    askEmail: b3.accounts?.askEmail or= true
    userEmail: Session.get 'userEmail'
)

Template.signUpPage.created = ->
    console.log 'signUpPage created'

Template.signUpPage.destroyed = ->

Template.signUpPage.events(
    'click button#signUp': b3.accountEvents.signUp
    'focusout input': (e, t) ->
        $('div.has-error').popover('destroy')
        b3.accountEvents.inputEmail(e,t)


)


