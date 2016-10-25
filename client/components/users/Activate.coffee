Template.Activate.events
    'submit form[Activate-form]': (event)->
        event.preventDefault()
        password1 = event.target.password1.value
        password2 = event.target.password2.value
        token = event.target.token.value
        if(password1==password2)
            console.log("PASSWORD")
            console.log(password1)
            console.log(password2)
            Meteor.call "doResetPassword",token,password1,(error,result)->
                    if(error) 
                        toastr.error("ERROR "+error.reason)
                    else
                        toastr.success("Account activated")
                
        
        
            
        
        
    