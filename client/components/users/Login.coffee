Template.Login.events(
     'submit [Login-form]form': (event)->
         event.preventDefault()
         email = $('[name=email]').val()
         password = $('[name=password]').val()
         Meteor.call("doLogin",email, password, (success,result)->
                if(result) 
                    Meteor.call("getUserByEmail",email,(success,user)->
                        #ServerSession.set("currentUser",user)
                        toastr.success("Logged in")
                        FlowRouter.go("home")
                    )
                    
                else 
                    toastr.error("WRONG PASSWORD")
                )
    )