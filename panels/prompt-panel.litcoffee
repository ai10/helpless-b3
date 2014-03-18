Prompt panel w/ bootstrap 3, Meteor.
---

    b3 = @b3

    Prompts = new Meteor.Collection null

    Prompt = (options) ->
         if not (@ instanceof Prompt) then return new Prompt options
         _.defaults options, @defaults

         oldP = Prompts.findOne {}
         console.log 'Prompt Options', options
         if oldP?._id?
             Prompts.update oldP._id, options

         else
             Prompts.insert options

    Prompt::defaults = {
        panelType: 'prompt-default'
        headerIcon: "glyphicon glyphicon-log-in"
        header: "Authentication."
        text: ""
        type: 'info'
        selectClass: 'selectClass'
        labelType: 'info'
        dialog: true
        confirmation: true
        legendIcon: "glyphicon glyphicon-envelope"
        legend: "Email identity."
        placeholder: ""
        buttonClass: "btn btn-info"
        inputSelect: 'inputSelect'
        buttonSelect: "buttonSelect"
        buttonLink: "#"
        buttonText: " confirm"
        buttonIcon: "glyphicon glyphicon-send"
        showAltButton: false
        altSelect: "altSelectClass"
        altButtonClass: "btn btn-default"
        altButtonLink: "#"
        altButtonText: " cancel"
        altButtonIcon: "glyphicon glyphicon-remove-sign"
        inputType: "text"
        $value: ""
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
        promptTag: Prompt::scurry {
            panelType: 'panel-default'
            headerIcon: 'glyphicon glyphicon-tags'
            header: 'Apply tags.'
            text: 'Short labels for the content item.'
            legendIcon: 'glyphicon glyphicon-tag'
            legend: 'Tag'
            buttonText: 'Tag.'
            buttonIcon: 'glyphicon glyphicon-tag'
            selectClass: 'applyTag'
            label: 'Apply a thoughtful tag.'
            hasTags: true
            validation: 'parsley-maxwords=1'
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

    Template.b3Prompt.created = ->
        console.log 'b3PromptCreated', this

    Template.b3Prompt.rendered = ->
        if @data.dialog
            if @data.$value.length > 1 then return
            first = @firstNode
            setTimeout =>
                $f = $(first).find('input')
                $f?.parsley('destroy')?.parsley b3.parsley
                $f?.focus()
            ,
                100
    
    Template.b3Prompt.tagsList = ->
        target = xAPI.activities.findOne({ _id: @target })
        _.map target.tags, (t) ->
            {
                tag: t
                target: target._id
            }

    Template.b3Prompt.events
         'click button.close': (e, t)->
             e.preventDefault()
             Prompt::remove @_id

         'click button.confirm': (e, t)->
             e.preventDefault()
             console.log 'button confirm'
             Prompt::remove @_id

         'click button#applyTag': (e, t) ->
             e.preventDefault()
             target = @target
             applyTag(e, t, target)

         'click button.remove': (e, t) ->
             e.preventDefault()
             tag = e.target.id
             target = e.target.value
             console.log 'remove', tag, target
             u = xAPI.activities.update { _id: target }, {
                 $pull: { tags: tag }
             }
             console.log 'update', u
             true
         'keyup input.applyTag': (e, t) ->
             unless e.keyCode is 13
                 return
             target = @target
             applyTag(e, t, target)

    applyTag = (e, t, target) ->
        f = t.firstNode or e.target.form
        $i = $(f).find('input.form-control')
        v = $i.parsley('validate')
        console.log 'valid', v
        tag = $i[0].value
        console.log 'applytag', tag, target
        u = xAPI.activities.update { _id: target }, {
                 $addToSet: { tags: tag }
        }
        console.log 'update', u
        true

    Template.promptStage.prompts = ->
        Prompts.find({}).fetch()
