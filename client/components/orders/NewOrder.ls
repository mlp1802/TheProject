getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
setCurrentOrder = (order)->Template.instance().currentOrder.set(order)


Template.NewOrder.created = ->
  currentOrder =
        customerId:this.data.customer._id
        customerName:this.data.customer.name
        productName:""
        address:this.data.customer.address
        amount:0
        quantity:0



  this.currentOrder = new ReactiveVar(currentOrder)
  this.orderStatus = new ReactiveVar("new")

Template.NewOrder.helpers(
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
)

Template.NewOrder.events(
  'click [backToEditOrder]':->setOrderStatus("new")
  'click [confirmNewOrder]':(event)->
      Meteor.call("newOrder",getCurrentOrder())


  'submit form':(event)->
      event.preventDefault()
      name = event.target.name.value
      address = event.target.address.value
      amount= event.target.amount.value
      quantity = event.target.quantity.value
      currentOrder =
          customerId:this.customer._id
          customerName:getCurrentOrder().customerName
          productName:name
          address:address
          amount:amount
          quantity:quantity
      setCurrentOrder(currentOrder)
      setOrderStatus("confirm")

)
