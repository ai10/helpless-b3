Form parsing helper
===

    b3 = @b3
    b3.parseForm = (el)->
        if not el then return false
        $el = $ el
        inputs = $el.serializeArray()
        console.log 'parseForm inputs', inputs
        output = {}
        _.each inputs, (i)->
             keys = i.name?.split(/\./)
             subscript = (object, keys, value) ->
                 key = keys.shift()
                 if keys.length is 0
                     object[key] = value
                     return object
                 if object[key]?
                     return subscript object[key], keys, value
                 object[key] = subscript {}, keys, value
             subscript output, keys, i.value
        output
