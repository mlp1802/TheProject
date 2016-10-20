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
                   companyName:companyName
        Meteor.call("registerClient",user)       
        Meteor.loginWithPassword(email, password, (error)->
            FlowRouter.go("/"))
        
            
        
        
    