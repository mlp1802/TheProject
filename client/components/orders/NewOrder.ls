getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
setupCurrentOrder= ->
  data = Template.instance().data
  order = data.order
  if order == undefined
          console.log("NEW ORDER LOL2")
          customerId:data.customer._id
          customerName:data.customer.name
          address:data.customer.address
          orderItems:[]
  else
          order

updateOrder = -> Meteor.call("updateOrder",getCurrentOrder())
newOrder = -> Meteor.call("newOrder",getCurrentOrder())
saveOrder = (order)->
    if(order._id==undefined)
      newOrder()
    else
      updateOrder()


Template.NewOrder.created = ->
  this.currentOrder = new ReactiveVar(setupCurrentOrder())
  this.orderStatus = new ReactiveVar("main")
  this.totalAmount = new ReactiveVar(0)


Template.NewOrder.helpers(
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
  "totalAmount":->Template.instance().totalAmount.get()
  )

Template.NewOrder.events(
  'click [submitOrder]':->setOrderStatus("confirm")
  'click [NewOrder-addOrderItem]':->setOrderStatus("orderItem")
  'click [NewOrder-backToEditOrder]':->setOrderStatus("main")
  'click [NewOrder-closeOrderItem]':->setOrderStatus("main")
  'click [NewOrder-confirmNewOrder]':(event)->
      saveOrder getCurrentOrder()
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
