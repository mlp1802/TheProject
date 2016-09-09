function getOrderStatus() {
  return Template.instance().orderStatus.get()
}

function setOrderStatus(v) {
    Template.instance().orderStatus.set(v)
}
function setCurrentOrder(order) {
    Template.instance().currentOrder.set(order)
}
function getCurrentOrder() {
    return Template.instance().currentOrder.get()
}
Template.NewOrder.created = function() {
  this.currentOrder = new ReactiveVar()
  this.orderStatus = new ReactiveVar("new")

}

Template.NewOrder.helpers({
  "orderStatus":function() {
    return getOrderStatus()
  },
  "eq":function(a,b) {
    return a==b
  },
  "currentOrder":function() {
    return getCurrentOrder()
  }
})
Template.NewOrder.events( {
  'click [backToEditOrder]':function() {
    setOrderStatus("new")
  },
  'submit form': function(event){
      event.preventDefault();
      var name = event.target.name.value;
      var address = event.target.address.value
      var amount= event.target.address.amount
      var quantity = event.target.address.quantity


      let currentOrder = {
        customerId:this.customer._id,
        customerName:this.customer.name,
        "name":name,
        "address":address,
        "amount":amount,
        "quantity":quantity
       }
      setCurrentOrder(currentOrder)
      setOrderStatus("confirm")

    }
  }
)
