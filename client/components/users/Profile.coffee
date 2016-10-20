
{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.Profile.events
    "submit form[Profile-form]":(event)->
        event.preventDefault()
        firstName =  event.target.firstName.value
        lastName =   event.target.lastName.value
        profile =
            firstName:firstName
            lastName:lastName
            address:getAddressFormFields(event.target)
        Meteor.call('updateProfile',profile)
        toastr.success("Profile","Profile updated ")
        #FlowRouter.go("customers")
        

