
function getCustomersByName() {
  return Companies.find({}, {sort: {name: 1}}).fetch();
}
function getCustomersByDate() {
  return Companies.find({}, {sort: {created_at: -1}}).fetch();
}

Template.CustomerList.created = function() {
    this.subscribe("companies")
    this.sortOrder = new ReactiveVar("by_name")
}
Template.CustomerList.helpers({
  companies:()=> {
    let sortOrder = Template.instance().sortOrder.get()
    if(sortOrder=="by_name") {
      return getCustomersByName()
    }
    if(sortOrder=="by_date") {
      return getCustomersByDate()
    }
  }
})

Template.CustomerList.events(
  {
    'click .by_date': function(event){
        Template.instance().sortOrder.set("by_date")

      },
      'click .by_name': function(event){
          Template.instance().sortOrder.set("by_name")
        }
   }
)
