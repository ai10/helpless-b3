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

        b3.timeouts[aId] = tim1
        b3.alarms[aId] = tim2
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
    else
        id = Modals.insert a

    flashouts id, a
    @id = id

Modal::defaults = {
            type: 'default'
            icon: false
            timeout: false
            header: "Modal."
            template: 'standardModal'
            text: ""
            footer:
                header:'footerheader'
                text: 'footertext'
                label: 'footerlabel'
            link: false
            dialog: false
            confirmation: true
            block: ""
            soundoff: ""
            buttonClass: "btn btn-info"
            selectId: "footerButton"
            buttonLink: "#"
            buttonText: " Confirm"
            buttonIcon: "glyphicon glyphicon-send"
            showAltButton: true
            altSelectId: "altFooterButton"
            altButtonClass: "btn btn-warning"
            altButtonLink: "#"
            altButtonText: " Cancel"
            altButtonIcon: 'glyphicon glyphicon-remove-sign'
            inputType: "text"
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

Modal::video = (parent, videoInfo) ->
    videoInfo = videoInfo or {}
    videoDefaults = {
        id: 'modalVideo'
        poster: 'poster.jpg'
        title: 'movie.mp4'
        videoType: 'video/mp4'
    }
    _.defaults videoInfo, videoDefaults
    return new Modal {
        header: parent?.title or 'Modal'
        template: 'video'
        video: videoInfo
    }

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
    interactiveModal: Modal::interactive
    videoModal: Modal::video
    modalSetDefaults: Modal::setDefaults
}

_.each modalCurries, (v, k) ->
    b3[k] = v


b3.Modal = Modal

b3.modalSequence = (sequence) ->
    console.log 'modalSequence', sequence
    unless _.isArray sequence then throw new Meteor.Error 415, 'sequence must be an array.'
    list = _.sortBy sequence,(modal) ->
        if modal.number? then return modal.number
        if modal.rank? then return modal.rank
        if modal.timestamp? then return modal.timstamp

    console.log 'sequencelist', list
    b3.modalSequenceList = list
    b3.modalSequenceStep = 0
    b3.toModal b3.modalSequenceStep

b3.toModal = (step)->
    unless typeof step is 'number' then throw new Meteor.Error 415, 'sequence must be an array.'
    hasNext = false
    hasPrevious = false
    hasFinish = false
    if step < (b3.modalSequenceList.length - 1)
        hasNext = true
    if step > 0
        hasPrevious = true
    if step is (b3.modalSequenceList.length - 1)
        hasFinish = true

    defaults = {
        isSequence: true
        hasNext: hasNext
        hasPrevious: hasPrevious
        hasFinish: hasFinish
        template: 'interactive'
        single: 'sequence'
    }
    modal = b3.modalSequenceList[step] or {}
    _.defaults modal, defaults
    b3.modalSequenceStep = step
    b3.Modal modal

b3.nextModal = ->
    lastStep = b3.modalSequenceStep
    nextStep = lastStep + 1
    if nextStep >= b3.modalSequenceList.length
        throw new Meteor.Error 415, 'Step exceeds sequence length.'
    b3.toModal nextStep

b3.previousModal = ->
    lastStep = b3.modalSequenceStep
    previousStep = lastStep - 1
    if previousStep < 0
        throw new Meteor.Error 415, 'Step before sequence bounds.'
    b3.toModal previousStep

