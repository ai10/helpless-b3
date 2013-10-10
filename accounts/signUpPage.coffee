
class signUpPageController extends RouteController
    template: 'signUpPage'

Template.signUpPage.rendered = ->
    console.log 'signUpPageRendered'

Template.signUpPage.helpers(
    logo: 'logo.jpeg'
    loginServices: b3.accounts?.loginServices or= false
    askNames: b3.accounts?.askNames or= true
    askEmail: b3.accounts?.askEmail or= true
)

Template.signUpPage.created = ->
    console.log 'signUpPage created'

Template.signUpPage.destroyed = ->

Template.signUpPage.events(
    'click button#signUp': b3.formEvent.signUp

)


