clientDao = require("../../queries")
self = null
getStatus =->self.status.get()
setStatus =(v)->self.status.set(v)

subscribeToCreateOrder = (msg,order)->
   this.$("#closeOrder").click()

updateOrders =(callback) ->
    clientDao.getOrdersByCustomerId self.data.customer._id,
      (error,orders)->
        self.orders.set(orders)
        if callback then callback(orders)
Template.OrdersAdmin.created = ->
  self = this
  self.status = new ReactiveVar("menu")
  self.orders = new ReactiveVar()
  PubSub.subscribe("orderCreated",subscribeToCreateOrder)
  PubSub.subscribe "orderUpdated",(msg,obj)->updateOrders()
Template.OrdersAdmin.helpers
  "customerOrders":->Template.instance().orders.get()
  "status":->getStatus()
  "eq":(a,b)->a is b

Template.OrdersAdmin.events
  "click [OrdersAdmin-closeCustomerOrders]":(event)->setStatus("menu")
  "click [OrdersAdmin-order]":(event)->setStatus("order")
  "click [OrdersAdmin-allOrders]":(event)->
  	#self = Template.instance()
    updateOrders (orders)->
          setStatus("allOrders")
