function getStatus() {
  return Template.instance().status.get()
}

function setStatus(v) {
    Template.instance().status.set(v)
}

Template.OrdersAdmin.created = function() {
  console.log("creating status")
  this.status = new ReactiveVar("menu")
}


Template.OrdersAdmin.helpers({
  "status":function() {
    return getStatus()
  },
  "eq":function(a,b) {
    return a==b
  }
})
Template.OrdersAdmin.events(
  {
    'click [order]': function(event){
      setStatus("order")
    },
  }
)
