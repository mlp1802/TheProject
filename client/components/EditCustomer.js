Template.EditCustomer.events(
  {
    'submit form': function(event){
        event.preventDefault();
        //var name = event.target.name.value;
        //var address = event.target.address.value
        var id= this.customer._id
        var name = event.target.name.value;
        var address = event.target.address.value
        //Meteor.call('createCompany', name,address)
        //FlowRouter.go("customers")
        //Meteor.call("updateCustomer",id,name,address)
      },
      'click .cancelEditCustomer': function(event){
          event.preventDefault();
          console.log("click cancel edit");
          //Session.set(getId()+"editCustomer",false)
        }
  }
)
