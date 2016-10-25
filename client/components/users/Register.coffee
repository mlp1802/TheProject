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
               firstName:firstName
               lastName:lastName
        client = 
               email: email
               companyName:companyName

        Meteor.call("registerClient",client,user)       
        Meteor.loginWithPassword(email, password, (error)->
            FlowRouter.go("/"))
        
            
        
        
    