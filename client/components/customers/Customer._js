Template.Customer.created = function() {
  this.showDetails = new ReactiveVar(false)
  this.showEdit = new ReactiveVar(false)
  this.showOrders = new ReactiveVar(false)
}
function setShowDetails(v) {
  Template.instance().showDetails.set(v)
}
function setShowEdit(v) {
  Template.instance().showEdit.set(v)
}
function setShowOrders(v) {
  Template.instance().showOrders.set(v)
}
function getShowOrders() {
  return Template.instance().showOrders.get()
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
    return !(getShowEdit()||getShowDetails()||getShowOrders())
  },
  showEdit:()=> {
    return getShowEdit()
  },
  showOrders:()=> {
    return getShowOrders()
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
     "click [orders]":function() {
       setShowOrders(true)
       setShowDetails(false)
    }
    ,
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
