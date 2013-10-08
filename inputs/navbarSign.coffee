Template.navbarSign.rendered = ->
    f = @firstNode
    p = b3.parsley
    $(f)?.parsley('destroy')?.parsley p
    true


