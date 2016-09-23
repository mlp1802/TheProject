{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")
getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
getCustomer= () -> customer = Template.instance().data.customer
        
        
                
setupCurrentOrder= ->
  data = Template.instance().data
  order = data.order
  customer = getCustomer()
  if order == undefined
          customerId:customer._id
          customerName:customer.name
          address:customer.address
          orderItems:[]
          orderExtras:[]
  else
          order

updateOrder = -> Meteor.call("updateOrder",getCurrentOrder())
newOrder = -> Meteor.call("saveNewOrder",getCurrentOrder())
saveOrder = (order)->
    if(order._id==undefined)
      newOrder()
    else
      updateOrder()


Template.NewOrder.created = ->
  this.currentOrder = new ReactiveVar(setupCurrentOrder())
  this.orderStatus = new ReactiveVar("main")
  this.totalAmount = new ReactiveVar(0)


Template.NewOrder.helpers
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
  "totalAmount":->Template.instance().totalAmount.get()


Template.NewOrder.events
  'submit form[NewOrder-submitOrder]':(event)->
      event.preventDefault()
      console.log(Template.instance())
      getCurrentOrder().address = getAddressFormFields(event.target)
      setOrderStatus("confirm")
  'click [NewOrder-addOrderItem]':->setOrderStatus("orderItem")
  'click [NewOrder-addExtra]':->setOrderStatus("addExtra")
  'click [NewOrder-backToEditOrder]':->setOrderStatus("main")
  'click [NewOrder-closeOrderItem]':->setOrderStatus("main")
  'click [NewOrder-confirmNewOrder]':(event)->saveOrder getCurrentOrder()
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

  'submit form[AddExtraForm-form]':(event)->
      event.preventDefault()
      order = getCurrentOrder()
      name = event.target.name.value
      amount= event.target.amount.value
      extra =
          _id:Random.id()
          name:name
          amount:amount
      order.orderExtras.push(extra)
      console.log(order.orderExtras)
      setOrderStatus("main")
