
{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.NewUser.events
    "submit form[NewUser-form]":(event)->
        event.preventDefault()
        firstName =  event.target.firstName.value
        lastName =   event.target.lastName.value
        email = event.target.email.value
        user =
               email: email
               firstName:firstName
               lastName:lastName

        Meteor.call 'newUser',user, (error,result)->
          if error
            toastr.error(error.reason)
          else
            if result.error
              toastr.error result.reason
            else
              toastr.success("Admin","New user created")
              FlowRouter.go("users")

        #FlowRouter.go("customers")


