Template.NewCustomer.events(
  {
    'submit form': function(event){
        event.preventDefault();
        var name = event.target.name.value;
        var address = event.target.address.value
        Meteor.call('createCompany', name,address)
        FlowRouter.go("customers")
        }
  }
)
