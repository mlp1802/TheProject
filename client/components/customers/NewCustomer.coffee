{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.NewCustomer.events
    
    'submit form': ->
        event.preventDefault()
        name = event.target.name.value
        #console.log("getAddressFormFields = "+getAddressFormFields)
        company =
            name:name
            address:getAddressFormFields(event.target)

        Meteor.call('createCompany', company)
        FlowRouter.go("customers")
        
