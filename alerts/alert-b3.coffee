b3 = @b3
b3.timeouts = {}
b3.alarms = {}
b3.hoverAfters = {}
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
        if lert.hoverAfter > 0
            tim3 = setTimeout(->
                Alerts.update {_id: aId}, {$set: {hoverDismiss: true}}
            ,
                lert.hoverAfter
            )

        b3.timeouts[aId] = tim1
        b3.alarms[aId] = tim2
        b3.hoverAfters[aId] = tim3
        true


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
        if b3.hoverAfters[id]?
            clearTimeout b3.hoverAfters[id]
    else
        id = Alerts.insert a

    flashouts id, a
    @id = id

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


Alert::curry = (extension)->
    return (text, options = {}) ->
        a = _.clone extension
        options.text = text
        a = _.extend a, options
        return new Alert a

Alert::setDefaults = (defaults) ->
    oldDefaults = @defaults
    _.extend oldDefaults, defaults
    @defaults = oldDefaults


Alert::remove = (id)->
    if typeof id is 'string'
        Alerts.remove {_id: id }
    if typeof id is 'object'
        Alerts.remove id

Alert::clearAll = ->
    Alerts.remove({})

alertsCurries = {
        alertDanger: Alert::curry {
            header: "danger"
            type: 'danger'
        }
        alertSuccess: Alert::curry {
            header: "success"
            type: 'success'
        }
        alertInfo: Alert::curry {
            header: "info"
            type: 'info'
        }
        alertWarning: Alert::curry {
            header: "warning"
            type: 'warning'
        }
        alertSetDefaults: Alert::setDefaults
        alertDialog: Alert::curry {
            dialog: true
            block: 'alert-block'
        }
        alertConfirmation: Alert::curry {
            dialog: true
            confirmation: true
            block: 'alert-block'
        }
        alertPrimary: Alert::curry {
            header: "primary"
        }
        flashError: Alert::curry {
            header: 'error'
            type: 'danger'
            timeout: 4200  #auto dismiss after
            hoverAfter: 2800 #hover will execute dismiss after
        }
        flashSuccess: Alert::curry {
            header: 'success'
            type: 'success'
            timeout: 4200
            hoverAfter: 2800
        }
        flashInfo: Alert::curry {
            header: 'info'
            type: 'info'
            timeout: 4200
            hoverAfter: 2800
        }
        flashWarn: Alert::curry {
            header: 'Warning:'
            type: 'warning'
            timeout: 4200
            hoverAfter: 2800
        }
        modalTime: Alert::curry {
            header: 'Time remaining:'
            type: 'warning'
            selectClass: 'uberModal'
            timeout: 18000
        }
}

_.each alertsCurries, (v, k) ->
    b3[k] = v


b3.Alert = Alert

Template.b3AlertList.helpers
    alerts: ->
        Alerts.find({region: @region}).fetch()
    zindex: ->
        if /middle/i.test @region
            return "z-index: 2020;"
        if /right/i.test @region
            return "z-index: 2060;"
        ""

    middle: ->
        if /middle/i.test @region
            return 'middleAlert'
        ""
    center: ->
        if /center/i.test @region
            return 'centerAlert'
        ""
    vertical: ->
        scrollTop = $(window).scrollTop()
        height = $(window).height()
        nav = $('.navbar-fixed-top').height()
        if /top/i.test(@region)
            return "top: #{scrollTop+nav}px;"
        if /middle/i.test(@region)
            return "top: #{scrollTop+(height/2)}px;"
        if /bottom/i.test(@region)
            count = Alerts.find({ region: @region }).count()
            if not count?
                count = 1
            offset = (count+1)*nav
            return "top: #{scrollTop+height-offset}px;"
    horizontal: ->
        if /left/i.test(@region)
            return "left: 7px;"
        if /center/i.test(@region)
            return "right: 50%;"
        if /right/i.test(@region)
            return "right: 7px;"

Template.b3AlertsContainer.helpers
    regions: ->
        regs = ['topRight', 'middleRight', 'bottomRight',
         'bottomCenter', 'bottomLeft', 'middleLeft',
         'topLeft', 'topCenter', 'middleCenter'
        ]
        regmap =_.map regs, (r)->
            {region: r}

Template.b3Alert.rendered = ->
    if @data.dialog
        if @data.value.length > 1 then return
        first = @firstNode
        setTimeout =>
            $f = $(first).find('input')
            $f?.parsley('destroy')?.parsley b3.parsley
            $f?.focus()
        ,
            100

Template.b3Alert.events
    'click button.close': (e, t) ->
        e.preventDefault()
        Alert::remove(@_id)
    'mouseover div.alert': (e, t) ->
        e.preventDefault()
        if @hoverDismiss is true
            Alert::remove(@_id)

Template.b3Alert.helpers
    glyphicon: ->
        if @icon is false
            switch @type
                when 'info'
                    return "glyphicon glyphicon-info-sign"
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

