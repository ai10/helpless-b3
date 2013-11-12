b3 = @b3
@Modals = new Meteor.Collection null


Modal = (options)->
    if not (@ instanceof Modal) then return new Modal options
    flashouts = (aId, mdl) ->
        if mdl.timeout > 0
            tim1 = setTimeout( ->
                Modals.remove {_id: aId}
            ,
                mdl.timeout
            )
        if mdl.alarm > 0
            tim2 = setTimeout(->
                Modals.update {_id: aId}, {$set: {ringing: true}}
            ,
                mdl.alarm
            )
        if mdl.hoverAfter > 0
            tim3 = setTimeout(->
                Modals.update {_id: aId}, {$set: {hoverDismiss: true}}
            ,
                mdl.hoverAfter
            )

        b3.timeouts[aId] = tim1
        b3.alarms[aId] = tim2
        b3.hoverAfters[aId] = tim3
        true


    a = _.defaults options,  @defaults
    a.timestamp = new Date().valueOf()
    if options.single?
        oldA = Modals.findOne {single: options.single}
        id = oldA?._id

    if id?
        Modals.update id, a
        if b3.timeouts[id]?
            clearTimeout b3.timeouts[id]
        if b3.alarms[id]?
            clearTimeout b3.alarms[id]
        if b3.hoverAfters[id]?
            clearTimeout b3.hoverAfters[id]
    else
        id = Modals.insert a

    flashouts id, a
    @id = id

Modal::defaults = {
            type: 'default'
            icon: false
            timeout: false
            region: 'topRight'
            header: "Modal."
            template: 'standardModal'
            text: ""
            link: false
            dialog: false
            confirmation: false
            block: ""
            soundoff: ""
            buttonClass: "btn btn-info"
            selectClass: "selectClass"
            buttonLink: "#"
            buttonText: " Confirm"
            buttonIcon: "glyphicon glyphicon-send"
            showAltButton: false
            altSelectClass: "altSelectClass"
            altButtonClass: "btn btn-default"
            altButtonLink: "#"
            altButtonText: " Cancel"
            altButtonIcon: 'glyphicon glyphicon-remove-sign'
            inputType: "text"
            hoverDismiss: false
            hoverAfter: -1
            alarm: false
            ringing: false
            placeholder: ""
            value: ""
            label: "label"
            validation: ""
    }


Modal::curry = (extension)->
    return (header, options = {}) ->
        a = _.clone extension
        options.header = header
        a = _.extend a, options
        return new Modal a

Modal::setDefaults = (defaults) ->
    oldDefaults = @defaults
    _.extend oldDefaults, defaults
    @defaults = oldDefaults


Modal::remove = (id)->
    if typeof id is 'string'
        Modals.remove {_id: id }
    if typeof id is 'object'
        Modals.remove id

Modal::clearAll = ->
    Modals.remove({})

Modal::show = (modal)->
    if typeof modal is 'object'
        Modals.update modal, { visisble: 'visible' }


modalCurries = {
    modalDashboard: Modal::curry {
        header: "#{Meteor.user()?.emails[0]?.address} Dashboard."
        template: 'dashboard'
    }
    modalVideo: Modal::curry {
        header: "Video"
        template: 'video'
    }
    modalCanvas: Modal::curry {
        header: "Canvas"
        template: 'canvas'
    }
    modalChoice: Modal::curry {
        header: "Choice"
        template: 'choice'
    }
    modalAnswer: Modal::curry {
        header: "Answer"
        template: 'answer'
    }
    modalStandard: Modal::curry {
        header: "Standard"
        template: 'standard'
    }
    modalSetDefaults: Modal::setDefaults
}

_.each modalCurries, (v, k) ->
    b3[k] = v


b3.Modal = Modal

