In-place editable field
===


      Template.ip.created = (field)->
          console.log 'ip', this, field
          Session.set 'ipEdit:'+@_id, false

      Template.ip.result = (key, collection)->
          console.log 'result', key, collection, this
          if @[key] then return @[key]
          'void result'

      Template.ip.ipEdit = (key, collection)->
          console.log 'ipEdit', this, key, collection
          Session.get 'idTag'+@_id+key

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
              idTag = 'idTag'+@_id+e.target.dataset?.key
              Session.set idTag, true
              'frodo'

          'submit form': (e, t) ->
              e.preventDefault()
              value = e.target[0].value
              key = e.target.dataset.key
              id = e.target.dataset.id
              collection = e.target.dataset.collection
              transform = e.target.dataset.transform
              if transform?
                  key = transform+'.'+key
              query = {}
              query[key] = value
              collection_keys = collection.split('.')
              console.log 'ck', collection_keys
              space = window
              collection_keys.forEach (k)->
                  console.log 'key', k, space
                  space = space[k]
              console.log 'space', space, query
              space.update({ _id: id }, { $set: query })
              idTag = 'idTag'+@_id+e.target.dataset.key
              Session.set idTag, false
              'yo'
