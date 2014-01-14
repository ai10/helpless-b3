Form parsing helper
===

    ParseForm = (el)->
        if not el then return false
        $el = $ el
        inputs = $el.serializeArray()
        _.map inputs, (i)->
             keys = i.name?.split(/\./)
             subscript = (object, keys, value) ->
                 key = keys.shift()
                 if keys.length is 0
                     return object[key] = value
                 object[key] = subscript {}, keys, value

        inputs
