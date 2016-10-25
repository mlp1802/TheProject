Template.ResetPassword.events
    'submit form[ResetPassword]': (event)->
        event.preventDefault()
        password1 = event.target.password1.value
        password2 = event.target.password2.value
        console.log("PASSWORD")
        console.log(password1)
        console.log(password2)
        
            
        
        
    