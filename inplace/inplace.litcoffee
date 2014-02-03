In-place editable field
===


      Template.ip.created = (field)->
          console.log 'ip', this, field
          Session.set 'ipEdit:'+@_id, false

      Template.ip.result = (field, collection)->
          console.log 'result', field, collection, this
          if @[field] then return @[field]
          'void result'

      Template.ip.ipEdit = (field, collection)->
          console.log 'ipEdit', this, field, collection
          Session.get 'idTag'+@_id+field

      Template.ip.id = ->
          console.log 'ip id', this
          if @_id then return @_id
          'void'

      Template.ip.events
          'dblclick span': (e, t)->
              e.preventDefault()
              unless Meteor.user() then return
              console.log 'double id', e.target
              console.log 'double click', this
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
              console.log 'ck', collection_keys
              space = window
              collection_keys.forEach (k)->
                  console.log 'key', k, space
                  space = space[k]
              console.log 'space', space, query
              space.update({ _id: id }, { $set: query })
              idTag = 'idTag'+@_id+e.target.dataset.field
              Session.set idTag, false
              'yo'
