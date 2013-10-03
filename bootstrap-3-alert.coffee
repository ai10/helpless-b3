@Alerts = new Meteor.Collection null

Alert = (options) ->
    console.log "Alert", options
    d = @defaults ? {}
    a = _.extend d, options
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
            timeout: false
            layout: 'topRight'
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

_alertDefaults = (defaults) ->
    d = Alert::defaults ? {}
    Alert::defaults = _.extend d, defaults

_alertError = (text="", options={}) ->
    console.log "alertError"
    options.type = 'danger'
    options.header = "Error."
    options.text = text
    Alert options

_alertSuccess = (text="", options={}) ->
    options.type = 'success'
    options.header = "Success."
    options.text = text
    Alert options

_alertWarning = (text="", options={}) ->
    options.type = 'warning'
    options.header = "Warning."
    options.text = text
    Alert options

_alertInfo = (text="", options={}) ->
    options.type = 'info'
    options.header = "Header."
    options.text = text
    Alert options

_.mixin {
    alertError: _alertError
    alertSuccess: _alertSuccess
    alertWarning: _alertWarning
    alertInfo: _alertInfo
    alertDefaults: _alertDefaults
}

Template.alertRegion.helpers
    alerts: ->
        Alerts.find().fetch()

