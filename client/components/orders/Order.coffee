setStatus = (s)->Template.instance().status.set(s)
getStatus = ->Template.instance().status.get()
Template.Order.created = ->
    this.status = new ReactiveVar("overview")


Template.Order.events
  "click [Order-orderPanel]":->setStatus("editOrder")

Template.Order.events
  "click [Order-orderPanel]":->setStatus("editOrder")
  "click [NewOrder-confirm],[NewOrder-closeNewOrder]":->setStatus("overview")
  "submit [NewOrder-submitOrder]":->setStatus("overview") 

Template.Order.helpers
  "status":->getStatus()
  "eq":(a,b)->a is b

