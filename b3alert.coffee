Alerts = new Meteor.Collection null

Alert = (options)->
    if not @ instanceof Alert then return new Alert options
    a = _.defaults options,  @defaults
    a.timestamp = new Date().valueOf()
    aid = Alerts.insert a
    if a.timeout > 0
        setTimeout( ->
            Alerts.remove {_id: aid}
        ,
            a.timeout
        )
    if a.alarm > 0
        setTimeout(->
            Alerts.update {_id: aid}, {$set: {ringing: true}}
        ,
            a.alarm
        )

Alert::defaults = {
            type: 'default'
            icon: false
            timeout: false
            region: 'topRight'
            header: "Alert."
            text: ""
            link: false
            dialog: false
            confirmation: false
            block: ""
            soundoff: ""
            buttonClass: "btn btn-info"
            buttonLink: "#"
            buttonText: "Confirm"
            altButtonClass: "btn btn-default"
            altButtonLink: "#"
            altButtonText: "Cancel"
            inputType: "text"
            hover: false
            alarm: false
            ringing: false
    }

Alert::curry = (extension)->
    return (text, options = {}) ->
        a = _.clone extension
        options.text = text
        a = _.extend a, options
        return new Alert a

Alert::setDefaults = (defaults) ->
    _.extend Alert::defaults, defaults

@b3 = do ->
    {
        alertDanger: Alert::curry { header: "danger", type: 'danger'}
        alertSuccess: Alert::curry { header: "success", type: 'success'}
        alertInfo: Alert::curry { header: "info", type: 'info'}
        alertWarning: Alert::curry { header: "warning", type: 'warning'}
        alertSetDefaults: Alert::setDefaults
        alertDialog: Alert::curry { dialog: true, block: 'alert-block'}
        alertPrimary: Alert::curry { header: "primary" }
    }

Template.b3AlertList.helpers
    alerts: ->
        console.log 'alerts', @
        Alerts.find({region: @region}).fetch()
    vertical: ->
        console.log 'vertival', @
        if /top/i.test(@region)
            return 'topAlert'
        if /middle/i.test(@region)
            return 'middleAlert'
        if /bottom/i.test(@region)
            return 'bottomAlert'
    horizontal: ->
        console.log 'horiz', @
        if /left/i.test(@region)
            return 'leftAlert'
        if /center/i.test(@region)
            return 'centerAlert'
        if /right/i.test(@region)
            return 'rightAlert'

Template.b3AlertsContainer.helpers
    regions: ->
        regs = ['topRight', 'middleRight', 'bottomRight',
         'bottomCenter', 'bottomLeft', 'middleLeft',
         'topLeft', 'topCenter', 'middleCenter'
        ]
        regmap =_.map regs, (r)->
            {region: r}


Template.b3Alert.events
    'click button.close': (e, t) ->
        e.preventDefault()
        Alerts.remove({_id: @_id})
    'mouseover div.alert': (e, t) ->
        e.preventDefault()
        if @hover is true
            Alerts.remove { _id: @_id }

Template.b3Alert.helpers
    glyphicon: ->
        if @icon is false
            switch @type
                when 'info'
                    return "glyphicon glyphicon-tag"
                when 'danger'
                    return "glyphicon glyphicon-warning-sign"
                when 'warning'
                    return "glyphicon glyphicon-warning-sign"
                when 'success'
                    return "glyphicon glyphicon-ok"
                else
                    return "glyphicon glyphicon-question-sign"
        else
            return @icon

