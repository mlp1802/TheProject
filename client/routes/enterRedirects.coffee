enterRedirects =
  [
      {
         condition: ->not ServerSession.get("currentUser")
         action:->
                    console.log("not logged in")
                    FlowRouter.go("/login")
      }
      
  ]    
checkRedirects = ->
    redirect = enterRedirects.find((r)->r.condition())
    if redirect!=undefined
        redirect.action()

module.exports = { 
    checkRedirects
    }