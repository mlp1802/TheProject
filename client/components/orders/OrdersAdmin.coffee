{ClientDao} = require("../../clientDao/clientDao")
getStatus =->Template.instance().status.get()
setStatus =(v)->Template.instance().status.set(v)

subscribeToCreateOrder = (msg,order)->
   this.$("#closeOrder").click()

Template.OrdersAdmin.created = ->
  this.status = new ReactiveVar("menu")
  PubSub.subscribe("orderCreated",subscribeToCreateOrder)


Template.OrdersAdmin.helpers
  "customerOrders":->ClientDao.getOrdersByCustomerId(Template.instance().data.customer._id)
  "status":->getStatus()
  "eq":(a,b)->a is b
  


Template.OrdersAdmin.events
  #"submit [NewOrder-submitOrder]":(event)->setStatus("menu")
  #"click [NewOrder-confirmNewOrder]":->setStatus("menu")
  "click [OrdersAdmin-closeCustomerOrders]":(event)->setStatus("menu")
  "click [OrdersAdmin-order]":(event)->setStatus("order")
  "click [OrdersAdmin-allOrders]":(event)->setStatus("allOrders")

