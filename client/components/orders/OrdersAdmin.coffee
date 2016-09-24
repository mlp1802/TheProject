getStatus =->Template.instance().status.get()
setStatus =(v)->Template.instance().status.set(v)

Template.OrdersAdmin.created = ->
  this.status = new ReactiveVar("menu")


Template.OrdersAdmin.helpers
  "status":->getStatus()
  "eq":(a,b)->a is b


Template.OrdersAdmin.events
  "submit [NewOrder-submitOrder]":(event)->setStatus("menu")
  #"click [NewOrder-confirmNewOrder]":->setStatus("menu")
  "click [OrdersAdmin-order]":(event)->setStatus("order")
  "click [OrdersAdmin-allOrders]":(event)->setStatus("allOrders")

