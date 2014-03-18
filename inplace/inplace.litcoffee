In-place editable field
===


      Template.ip.created = (field)->
          Session.set 'ipEdit:'+@_id, false

      Template._ip.created = ->

      Template._ip.result = ->
          if @parent[@data.field] then return @parent[@data.field]
          'void compound'

      Template._ip.ipEdit = ->
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
          role = @data.role || 'any'
          unless Sentinel.allow role then return ''
          'inplace_edit'

      Template._ip.events
          'dblclick span': (e, t)->
              e.preventDefault()
              role = @data.role || 'any'
              user = Meteor.user()
              console.log 'role', role, user
              unless Sentinel.allow(role) then return
              idTag = 'idTag'+@parent._id+e.target.dataset?.field
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
