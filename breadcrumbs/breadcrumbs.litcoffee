Breadcrumb template
===

    Template.breadcrumbs.rendered = ->
    
    Template.breadcrumbs.breadcrumbs = ->
        bcid = @breadcrumb or @id
        b3.breadcrumbs?(bcid) or false
         
