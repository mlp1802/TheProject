Template.Login.events(
     'submit form': (event)->
         event.preventDefault()
         email = $('[name=email]').val()
         password = $('[name=password]').val()
         Meteor.call("doLogin",email, password, (success,result)->
                console.log("RESULT")
                console.log(result)
                if(result) 
                    Session.set("loggedIn",result)
                    
                    Meteor.call("getUserByEmail",email,(success,user)->
                        ServerSession.set("currentUser",user)
                        console.log("CURRENT USER") 
                        console.log(user)
                        Session.set("currentUser",user)
                        FlowRouter.go("home")
                    )
                    
                else 
                    console.log("WRONG PASSWORD")
                )
    )