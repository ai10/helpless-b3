Dynamic navbar items.
---


    b3 = @b3
    @NavbarItems = NavbarItems = new Meteor.Collection null


    NavItem = (options = {}) ->
        if not (@ instanceof NavItem) then return new NavItem options

        _.defaults options, @defaults

        if options.single?
            oldN = NavbarItems.findOne { single: options.single }
            if oldN?
                NavbarItems.update oldN._id, options
                oldN = null
                options = null
                return true

        @id = NavbarItems.insert options
        options = null
        true

    NavItem::defaults = {
        navGroup: 'default'
        title: 'NavItem'
        link: '#'
        isDropdown: false
        isSubItem: false
        parent: null
        class: ""
        active: ""
    }


    Template.navItems.rendered = ->

    Template.navItems.items = ->
        navGroup = Router._currentController?.options?.navGroup or 'default'
        NavbarItems.find({ navGroup: navGroup }, { limit: 4 }).fetch()

    Template.navItem.isDropdown = ->
        @isDropdown

    Template.navItem.link = ->
        @link

    Template.navItem.title = ->
        @title

    Template.navItem.rendered = ->

    Template.navItem.subItems = ->
        NavbarItems.find { parent: @_id }

    b3.navItem = NavItem

