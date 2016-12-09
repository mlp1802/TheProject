clientDao = require("../../clientDao/clientDao")
getStatus =->Template.instance().status.get()
setStatus =(v)->Template.instance().status.set(v)

subscribeToCreateOrder = (msg,order)->
   this.$("#closeOrder").click()

Template.OrdersAdmin.created = ->
  console.log("LOL"+this.customer)
  this.status = new ReactiveVar("menu")
  this.orders = new ReactiveVar()
  self = this
  clientDao.getOrdersByCustomerId this.data.customer._id,
  	(error,orders)->self.orders.set(orders)
  PubSub.subscribe("orderCreated",subscribeToCreateOrder)


Template.OrdersAdmin.helpers
  "customerOrders":->Template.instance().orders.get()
  "status":->getStatus()
  "eq":(a,b)->a is b



Template.OrdersAdmin.events
  #"submit [NewOrder-submitOrder]":(event)->setStatus("menu")
  #"click [NewOrder-confirmNewOrder]":->setStatus("menu")
  "click [OrdersAdmin-closeCustomerOrders]":(event)->setStatus("menu")
  "click [OrdersAdmin-order]":(event)->setStatus("order")
  "click [OrdersAdmin-allOrders]":(event)->
  	self = Template.instance()
  	#TODO this is repeated once before, make single function
  	clientDao.getOrdersByCustomerId self.data.customer._id,
	  	(error,orders)->self.orders.set(orders)
  		setStatus("allOrders")

