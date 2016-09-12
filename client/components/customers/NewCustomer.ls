Template.NewCustomer.events(
    'submit form': ->
        event.preventDefault()
        name = event.target.name.value
        address = event.target.address.value
        Meteor.call('createCompany', name,address)
        FlowRouter.go("customers")
        )
