getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
setCurrentOrder = (order)->Template.instance().currentOrder.set(order)


Template.NewOrder.created = ->
  this.currentOrder = new ReactiveVar()
  this.orderStatus = new ReactiveVar("new")

Template.NewOrder.helpers(
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
)

Template.NewOrder.events(
  'click [backToEditOrder]':->setOrderStatus("new")
  'submit form':(event)->
      event.preventDefault()
      name = event.target.name.value
      address = event.target.address.value
      amount= event.target.address.amount
      quantity = event.target.address.quantity
      currentOrder =
          customerId:this.customer._id
          customerName:this.customer.name
          name:name
          address:address
          amount:amount
          quantity:quantity

      setCurrentOrder(currentOrder)
      setOrderStatus("confirm")
)
