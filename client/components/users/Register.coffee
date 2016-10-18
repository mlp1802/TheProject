Template.Register.events
    'submit form': (event)->
        event.preventDefault()
        email = $('[name=email]').val()
        password = $('[name=password]').val()
        firstName = $('[name=firstName]').val()
        lastName = $('[name=lastName]').val()
        companyName = $('[name=companyName]').val()
        user = 
               email: email
               password: password
               profile:
                   firstName:firstName
                   lastName:lastName
        Meteor.call("registerClient",user)       
        console.log("LOGGIN IN")
        Meteor.loginWithPassword(email, password, (error)->
            FlowRouter.go("/"))
        
            
        
        
    