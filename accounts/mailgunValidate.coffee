#mailgun address validator interface

@b3.mailgunValidate = (address_text, options) ->

    if not address_text then return

    if address_text.length > 512
        error_message = 'Stream exceeeds maximum length of 512.'
        if options and options.error
            options.error error_message
        else
            console.log error_message

        return false

    if options and options.in_progress
        options.in_progress()

    success = false

    $.ajax
        type: "GET"
        url: 'https://api.mailgun.net/v2/address/validate?callback=?'
        data: { address: address_text, api_key: b3.validate_api_key }
        dataType: "jsonp"
        crossDomain: true
        success: (data, status) ->
            if not data.is_valid
                Session.set('dynaEmailValid', false)
                Session.set('dynaEmailMaybe', "")
                if not data.did_you_mean?
                    data.did_you_mean = 'something else..?'
                b3.flashWarn data.did_you_mean, { header: "#{address_text} invalid, did you mean:", single: 'dynaUser' }
                Session.set('dynaStep', 1)

        error: (request, status, error) ->
            console.log 'mailgun error', request, status, error




