getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
setCurrentOrder = (order)->Template.instance().currentOrder.set(order)


Template.NewOrder.created = ->

  currentOrder =
        customerId:this.data.customer._id
        customerName:this.data.customer.name

        address:this.data.customer.address

        orderItems:[]
  this.currentOrder = new ReactiveVar(currentOrder)
  this.orderStatus = new ReactiveVar("orderItem")
  this.totalAmount = new ReactiveVar(0)


Template.NewOrder.helpers(
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
  "totalAmount":->Template.instance().totalAmount.get()
)


Template.NewOrder.events(
  'click [submitOrder]':->setOrderStatus("confirm")
  'click [addOrderItem]':->setOrderStatus("orderItem")
  'click [backToEditOrder]':->setOrderStatus("main")
  'click [confirmNewOrder]':(event)->
      Meteor.call("newOrder",getCurrentOrder())
  'submit form[newOrderItem]':(event)->
      event.preventDefault()
      order = getCurrentOrder()
      name = event.target.name.value
      amount= event.target.amount.value
      quantity = event.target.quantity.value

      orderItem =
          _id:Random.id()
          productName:name
          amount:amount
          quantity:quantity
      order.orderItems.push(orderItem)
      setOrderStatus("main")

)
