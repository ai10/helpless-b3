Prompt panel w/ bootstrap 3, Meteor.
---

    b3 = @b3

    Prompts = new Meteor.Collection null

    Prompt = (options) ->
         if not (@ instanceof Prompt) then return new Prompt

         opts = _.defaults options, @defaults

         oldP = Prompts.findOne {}
         id = oldP?._id
         
         if id?
             Prompts.update id, opts

         else
             id = Prompts.insert p

    Prompt::defaults = {
        panelType: 'prompt-default'
        headerIcon: "glyphicon glyphicon-log-in"
        header: "Authentication."
        legendIcon: "glyphicon glyphicon-envelope"
        legend: "Email identity."
        placeholder: "input email"
        }
