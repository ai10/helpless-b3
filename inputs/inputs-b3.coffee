
Template.inputAreaB3.helpers
    inputConstraints: ->
        console.log 'inputconstraints', @
        constraints = " "
        _.each @constraints, (c) ->
            constraints += c
            constraints += "  "

        return constraints

Template.inputB3.helpers
    getInputs: ->
        inputs = _.clone @inputs
        without = _.omit @, 'inputs'
        _.each inputs, (i) ->
            _.extend i, without
        inputs


Template.inputB3.rendered = ->
    console.log 'b3inputgroup', @
    f = @firstNode
    p = @data.parsley
    $(f)?.find('input').parsley('destroy')?.parsley p
    true

Template.inputAreaB3.rendered = ->
    console.log 'input area', @

getSign = (text)->
    if b3.accounts.config.icons is true
        switch text
            when "Sign Up"
                type = "edit"
            when "Sign In"
                type = "log-in"
            when "Sign Out"
                type = "log-out"
            else
                type = "asterisk"

        return '<span class="glyphicon glyphicon-'+type+'></span>'+text
    else
        return text

b3.accounts = {
  config:
    wrapLinks: true
    homeRoute: 'home'
    dashboardRoute: 'dashboard'
    inline: true
}
