InputGroup = (options) ->
    if not (@ instanceof InputGroup) then return new InputGroup options
    _.each options, (v, k) =>
        _.defaults options[k], @defaults[k]

    _.defaults options, @defaults



InputGroup::defaults = {
    popover:
        animation: true
        html: false
        placement: 'right'
        selector: false
        trigger: 'focus'
        title: 'Invalid'
        content: 'Input required:'
        delay:
            show: 50
            hide: 100
        container: false
   label:
        srOnly: ""
        columns: ""
        title: 'Input'
    input:
        columns: ''
        hasAddon: false
        addon: '$'
    inputs: []
    button:
        hasButton: false
        style: 'default'
        label: 'Submit'
        type: 'submit'
    id: 'b3InputGroup'
}

b3.setInputGroupDefaults = (defaults) ->
    _.extend InputGroup::defaults, defaults

InputItem = (options) ->
    if not (@ instanceof InputItem) then return new InputItem options
    _.defaults options, @defaults

InputItem::defaults = {
    id: 'textInput'
    size: ""
    inputType: 'text'
    placeholder: 'Input'
    value: ""
    constraints: []
    triggers: 'submit'
    disabled: ""
}

passwordInput = new InputItem {
    id: 'passwordInput'
    inputType: 'password'
    placeholder: 'Password'
    constraints: [
        'data-required=true'
        'data-type=password'
        'data-hasnumber=1'
        'data-hasletter=1'
        'data-minlength=6'
    ]
    triggers: 'input focusin'
}

emailInput = new InputItem {
    id: 'emailInput'
    inputType: 'text'
    placeholder: 'Email'
    constraints: [
        'data-required=true'
        'data-type=email'
    ]
    triggers: 'input focusin'
}

emailReEnter = new InputItem {
    id: 'emailReEnter'
    inputType: 'text'
    placeholder: 'Re-enter email'
    constraints: [
        'data-required=true'
        'data-equalto=input#b3emailInput'
        'data-type=email'
    ]
    triggers: 'input focusin'
}

usernameInput = new InputItem {
    id: 'Username'
    inputType: 'text'
    placeholder: 'Username'
    constraints: []
    triggers: 'submit'
}

b3.emailPasswordGroup  = new InputGroup {
    inputs: [emailInput, passwordInput]
    label:
        srOnly: "srOnly"
        title: "Sign In"
    button:
        hasButton: true
        style: 'success'
        label: 'Sign In.'
}

