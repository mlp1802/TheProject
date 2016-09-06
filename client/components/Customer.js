Template.Customer.created = function() {
  this.showDetails = new ReactiveVar(false)
  this.showEdit = new ReactiveVar(false)
}
function setShowDetails(v) {
  Template.instance().showDetails.set(v)
}
function setShowEdit(v) {
  Template.instance().showEdit.set(v)
}
function getShowEdit() {
  return Template.instance().showEdit.get()
}
function getShowDetails() {
  return Template.instance().showDetails.get()
}
function toggleShowDetails() {
  setShowDetails(!getShowDetails())
}
Template.Customer.helpers({
  showDetails:()=> {
    return getShowDetails()
  },
  shouldShowHeader:function() {
    //return true;
    return !(getShowEdit()||getShowDetails())
  },
  showEdit:()=> {
    return getShowEdit()
  }
})
Template.Customer.events(
  {
    "click .customerClick":function() {
        toggleShowDetails()
    },
    "click .customerDetails":function() {
        setShowDetails(false)
    },
    "click [editCustomer]":function() {
        setShowDetails(false)
        setShowEdit(true)

    },
    'submit form.editCustomerForm ': function(event){
        var id = this.customer._id
        var name = event.target.name.value;
        var address = event.target.address.value
        Meteor.call("updateCustomer",id,name,address)
        setShowDetails(false)
        setShowEdit(false)

    },
    "click .cancelEditCustomer":function() {
      setShowDetails(false)
      setShowEdit(false)
    }
  })
