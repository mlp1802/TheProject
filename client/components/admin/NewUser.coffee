
{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.NewUser.events
    "submit form[NewUser-form]":(event)->
        event.preventDefault()
        firstName =  event.target.firstName.value
        lastName =   event.target.lastName.value
        email = event.target.email.value
        user = 
               email: email
               password: "password"
               profile:
                   firstName:firstName
                   lastName:lastName
                           
        Meteor.call('newUser',user)
        toastr.success("Admin","New user created")
        #FlowRouter.go("customers")
        

