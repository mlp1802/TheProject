var sortOrder = "by_name"
function getCustomersByName() {
  return Companies.find({}, {sort: {name: 1}}).fetch();
}
function getCustomersByDate() {
  return Companies.find({}, {sort: {created_at: -1}}).fetch();
}
Template.CustomerList.onCreated(function() {
  var self = this;
  self.autorun(function() {
    console.log("autorun lol")
    let a = function() {}
    self.subscribe("companies")
    Session.set("customers",getCustomersByName())

  });
})
Template.CustomerList.helpers({
  companies:()=> {
    console.log("Updating companies")
    let f = Session.get("customers")
    return f


  }
})

Template.CustomerList.events(
  {
    'click .by_date': function(event){
        event.preventDefault();
        console.log("BY DATE")
        Session.set("customers",getCustomersByDate())
        sortOrder = "by_date"

      },
      'click .by_name': function(event){
          event.preventDefault();
          Session.set("customers",getCustomersByName())
          console.log("BY NAME")
          sortOrder = "by_name"
        }
   }
)
