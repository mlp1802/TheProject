Template.NewCustomer.events(
    'submit form': ->
        event.preventDefault()
        name = event.target.name.value
        address = event.target.address.value
        company =
            name:name
            address:address
        Meteor.call('createCompany', company)
        FlowRouter.go("customers")
        )
