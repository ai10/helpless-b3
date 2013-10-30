b3 = @b3
b3.timeouts = {}
b3.alarms = {}

Alerts = new Meteor.Collection null

Alert = (options)->
    if not (@ instanceof Alert) then return new Alert options
    flashouts = (aId, lert) ->
        if lert.timeout > 0
            tim1 = setTimeout( ->
                Alerts.remove {_id: aId}
            ,
                lert.timeout
            )
        if lert.alarm > 0
            tim2 = setTimeout(->
                Alerts.update {_id: aId}, {$set: {ringing: true}}
            ,
                lert.alarm
            )
        b3.timeouts[aId] = tim1
        b3.alarms[aId] = tim2


    a = _.defaults options,  @defaults
    a.timestamp = new Date().valueOf()
    if options.single?
        oldA = Alerts.findOne {single: options.single}
        id = oldA?._id

    if id?
        Alerts.update id, a
        if b3.timeouts[id]?
            clearTimeout b3.timeouts[id]
        if b3.alarms[id]?
            clearTimeout b3.alarms[id]
    else
        id = Alerts.insert a

    flashouts id, a

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

alertsCurries = {
        alertDanger: Alert::curry { header: "danger", type: 'danger'}
        alertSuccess: Alert::curry { header: "success", type: 'success'}
        alertInfo: Alert::curry { header: "info", type: 'info'}
        alertWarning: Alert::curry { header: "warning", type: 'warning'}
        alertSetDefaults: Alert::setDefaults
        alertDialog: Alert::curry { dialog: true, block: 'alert-block'}
        alertConfirmation: Alert::curry { dialog: true, confirmation: true, block: 'alert-block'}
        alertPrimary: Alert::curry { header: "primary" }
        alertConfirmPassword: Alert::curry { dialog: true, type: 'info', block: 'alert-block', inputType: 'password', header: 'Confirm Password', icon: "glyphicon glyphicon-certificate" }
        alertConfirmEmail: Alert::curry { dialog: true, type: 'info', block: 'alert-block', promptInput: 'text', header: 'Confirm Email', icon: 'glyphicon glyphicon-certificate' }
        flashError: Alert::curry { header: 'error', type: 'danger', timeout: 4200 }
        flashSuccess: Alert::curry { header: 'success', type: 'success', timeout: 4200 }
        flashInfo: Alert::curry { header: 'info', type: 'info', timeout: 4200 }
        flashWarn: Alert::curry { header: 'Warning:', type: 'warning' }
}

_.each alertsCurries, (v, k) ->
    b3[k] = v

Template.b3AlertList.helpers
    alerts: ->
        Alerts.find({region: @region}).fetch()
    vertical: ->
        if /top/i.test(@region)
            return 'topAlert'
        if /middle/i.test(@region)
            return 'middleAlert'
        if /bottom/i.test(@region)
            return 'bottomAlert'
    horizontal: ->
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
    'submit': (e, t) ->
        e.preventDefault()
        console.log "submit", e.target[0].value
    'input': (e, t) ->
        e.preventDefault()
        console.log 'validity', e.target.validity.valid, @

Template.b3Alert.helpers
    glyphicon: ->
        if @icon is false
            switch @type
                when 'info'
                    return "glyphicon glyphicon-tag"
                when 'danger'
                    return "glyphicon glyphicon-ban-circle"
                when 'warning'
                    return "glyphicon glyphicon-warning-sign"
                when 'success'
                    return "glyphicon glyphicon-ok"
                else
                    return "glyphicon glyphicon-question-sign"
        else
            return @icon

