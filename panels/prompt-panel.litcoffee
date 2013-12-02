Prompt panel w/ bootstrap 3, Meteor.
---

    b3 = @b3

    Prompts = new Meteor.Collection null

    Prompt = (options) ->
         if not (@ instanceof Prompt) then return new Prompt
         console.log 'pop', options
         _.defaults options, @defaults

         oldP = Prompts.findOne {}
         
         if oldP?._id?
             Prompts.update oldP._id, opts

         else
             Prompts.insert options

    Prompt::defaults = {
        panelType: 'prompt-default'
        headerIcon: "glyphicon glyphicon-log-in"
        header: "Authentication."
        text: ""
        type: 'info'
        labelType: 'info'
        dialog: true
        confirmation: true
        legendIcon: "glyphicon glyphicon-envelope"
        legend: "Email identity."
        placeholder: ""
        buttonClass: "btn btn-info"
        selectClass: "selectClass"
        buttonLink: "#"
        buttonText: " confirm"
        buttonIcon: "glyphicon glyphicon-send"
        showAltButton: false
        altSelectClass: "altSelectClass"
        altButtonClass: "btn btn-default"
        altButtonLink: "#"
        altButtonText: " cancel"
        altButtonIcon: "glyphicon glyphicon-remove-sign"
        inputType: "text"
        value: ""
        label: "Please input your email."
        validation: ""
    }

    Prompt::scurry = (extension) ->
        (text, options={})->
            p = _.clone extension
            options.text = text
            _.extend p, options
            new Prompt p

    promptScurries = {
        promptPassword: Prompt::scurry {
            inputType: 'password'
            placeholder: 'input password'
        }
        promptEmail: Prompt::scurry {
            inputType: 'email'
            placeholder: 'input email'
        }
    }

    _.each promptScurries, (v, k)->
        b3[k] = v

    b3.Prompt = Prompt


    Prompt::remove = (id)->
        if typeof id is 'string'
            Prompts.remove { _id: id }
        if typeof id is 'object'
            Prompts.remove id

    Prompt::clearAll = ->
        Prompts.remove {}

    Template.b3Prompt.rendered = ->
        if @data.dialog
            if @data.value.length > 1 then return
            first = @firstNode
            setTimeout =>
                $f = $(first).find('input')
                $f?.parsley('destroy')?.parsley b3.parsley
                $f?.focus()
            ,
                100

    Template.b3Prompt.events
         'click button.close': (e, t)->
             e.preventDefault()
             console.log 'click close'
             Prompt::remove @_id


    Template.promptStage.prompts = ->
        Prompts.find({}).fetch()
