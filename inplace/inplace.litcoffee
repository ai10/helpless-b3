In-place editable field
===


      Template.ip.created = (field)->
          console.log 'ip created', this, field
          Session.set 'ipEdit:'+@_id, false

      Template._ip.created = ->
          console.log '_ip created', this, arguments

      Template._ip.result = ->
          console.log '_ip result', this
          if @parent[@data.field] then return @parent[@data.field]
          'void compound'

      Template._ip.ipEdit = ->
          console.log 'ip edit', this
          Session.get 'idTag'+@parent._id+@data.field

      Template._ip.id = ->
          if @parent._id then return @parent._id
          'void'

      Template._ip.field = ->
          if @data.field then return @data.field
          'void'

      Template._ip.collection = ->
          if @data.collection then return @data.collection
          'void'

      Template._ip.prefix = ->
          if @data.prefix then return @data.prefix
          'void'

      Template._ip.inplace = ->
          unless Meteor.user() then return ''
          'inplace_edit'

      Template._ip.events
          'dblclick span': (e, t)->
              e.preventDefault()
              console.log 'dblclick _ip', e
              unless Meteor.user() then return
              idTag = 'idTag'+@parent._id+e.target.dataset?.field
              console.log idTag
              Session.set idTag, true
              'frodo'

          'submit form': (e, t) ->
              e.preventDefault()
              value = e.target[0].value
              field = e.target.dataset.field
              id = e.target.dataset.id
              collection = e.target.dataset.collection
              unless e.target.dataset.prefix is ""
                  field = e.target.dataset.prefix+'.'+field
              query = {}
              query[field] = value
              collection_keys = collection.split('.')
              space = window
              collection_keys.forEach (k)->
                  space = space[k]
              space.update({ _id: id }, { $set: query })
              idTag = 'idTag'+@parent._id+e.target.dataset.field
              Session.set idTag, false
