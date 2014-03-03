In-place editable field
===


      Template.ip.created = (field)->
          console.log 'ip created', this, field
          Session.set 'ipEdit:'+@_id, false

      Template.ip.result = (parent)->
          if parent[@field] then return parent[@field]
          'void compound'

      Template.ip.ipEdit = (parent)->
          console.log 'ip edit', this, sup
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
              unless e.target.dataset.prefix is ""
                  field = e.target.dataset.prefix+'.'+field
              query = {}
              query[field] = value
              collection_keys = collection.split('.')
              space = window
              collection_keys.forEach (k)->
                  space = space[k]
              space.update({ _id: id }, { $set: query })
              idTag = 'idTag'+@_id+e.target.dataset.field
              Session.set idTag, false
