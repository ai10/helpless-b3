b3.parsley = {
        inputs: 'input'
        excluded: 'input[type=hidden]'
        trigger: 'input change focusin'
        focus: 'first'
        validationMinLength: 3
        errorClass: 'has-error'
        successClass: 'has-success'
        validators:
            hasnumber: (val) ->
                if not /[0-9]/.test(val)
                    return false
                true
            hasletter: (val) ->
                if not /[a-z]/i.test(val)
                    return false
                true
        showErrors: true
        messages:
            hasnumber: "Needs a number."
            hasletter: "Needs a letter."

        validateIfUnchanged: true
        errors:
            classHandler: (e, r) ->
                p = e.parent()

            container: (e, r) ->
                p = e.parent()
                s = "div##{e.context.id}.popover"
                pop = $(s)
                $c= pop.find('.popover-content')
                if $c.length is 0
                    $(p).popover 'show'
                    $n = pop.find('.popover-content')
                    return $n
                return $c
            errorsWrapper: '<ul></ul>'
            errorElem: '<li></li>'
        listeners:
            onFieldValidate: ->
            onFormSubmut: ->
            onFieldError: ->
            onFieldSuccess: (elem) ->
                elem.parent().popover 'hide'
}
