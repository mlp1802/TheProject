Template.Register.created = ->
    this.registered = new ReactiveVar(false)
    this.email = new ReactiveVar()

Template.Register.helpers 
  "registered":->Template.instance().registered.get()
  "email":->Template.instance().email.get()



Template.Register.events
    
    'submit [Register-form]form': (event)->
        event.preventDefault()
        email = $('[name=email]').val()
        firstName = $('[name=firstName]').val()
        lastName = $('[name=lastName]').val()
        companyName = $('[name=companyName]').val()
        user = 
               email: email
               firstName:firstName
               lastName:lastName
        client = 
               email: email
               companyName:companyName

        registered = Template.instance().registered
        em = Template.instance().email
        Meteor.call "registerClient",client,user,(error,result)->
            if ! error 
              if result.error
                toastr.error(result.reason)
              else
                em.set(email)
                registered.set(true)    
            else
              toastr.error(error.reason)
        #Meteor.loginWithPassword(email, password, (error)->
        #   FlowRouter.go("/"))
        
            
        
        
    