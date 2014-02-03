In-place editable field
===


      Template.ip.created = (field)->
          Session.set 'ipEdit:'+@_id, false

      Template.ip.result = (field, collection)->
          if @[field] then return @[field]
          'void result'

      Template.ip.ipEdit = (field, collection)->
          Session.get 'idTag'+@_id+field

      Template.ip.id = ->
          if @_id then return @_id
          'void'

      Template.ip.events
          'dblclick span': (e, t)->
              e.preventDefault()
              unless Meteor.user() then return
              idTag = 'idTag'+@_id+e.target.dataset?.field
              Session.set idTag, true
              'frodo'

          'submit form': (e, t) ->
              e.preventDefault()
              value = e.target[0].value
              field = e.target.dataset.field
              id = e.target.dataset.id
              collection = e.target.dataset.collection
              prefix = e.target.dataset.prefix
              if prefix?
                  field = prefix+'.'+field
              query = {}
              query[field] = value
              collection_keys = collection.split('.')
              space = window
              collection_keys.forEach (k)->
                  space = space[k]
              space.update({ _id: id }, { $set: query })
              idTag = 'idTag'+@_id+e.target.dataset.field
              Session.set idTag, false
