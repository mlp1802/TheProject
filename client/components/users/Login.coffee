Template.Login.events(
     'submit form': (event)->
         event.preventDefault()
         email = $('[name=email]').val()
         password = $('[name=password]').val()
         Meteor.loginWithPassword(email, password, (error)->
                if(error) 
                    console.log(error.reason)
                else 
                    FlowRouter.go("home")
             
                )
    )