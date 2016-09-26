updateTotalAmount =(template) ->
  totalAmount = template.totalAmount
  order = template.data.order
  Meteor.call("getTotalAmount",order,
      (error,result)->totalAmount.set(result))




Template.OrderItems.created =
    ->
      template = Template.instance()
      order = template.data.order
      this.totalAmount = new ReactiveVar(template.data.totalAmount)
      this.getOrderItems = new ReactiveVar(order.orderItems)
      this.getOrderExtras = new ReactiveVar(order.orderExtras)
      Tracker.autorun(->updateTotalAmount(template))



Template.OrderItems.helpers 
    "getOrderItems":->Template.instance().getOrderItems.get()
    "getOrderExtras":->Template.instance().getOrderExtras.get()
    "totalAmount":->Template.instance().totalAmount.get()
    "eq":(a,b)->a is b
    

Template.OrderItems.events 
    "click [OrderItems-removeOrderItem]":(event)->
        id = event.currentTarget.attributes["OrderItems-removeOrderItem"].value 
        orderItems = this.order.orderItems
        newItems = orderItems.filter((item)->item._id!=id)
        orderItems.splice(0, orderItems.length)
        newItems.forEach((item)->orderItems.push(item))
        Template.instance().getOrderItems.set(orderItems)
        updateTotalAmount(Template.instance())

    "click [OrderItems-removeExtra]":(event)->
        id = event.currentTarget.attributes["OrderItems-removeExtra"].value 
        orderExtras = this.order.orderExtras
        newItems = orderExtras.filter((item)->item._id!=id)
        orderExtras.splice(0, orderExtras.length)
        newItems.forEach((item)->orderExtras.push(item))
        Template.instance().getOrderExtras.set(orderExtras)
        
        updateTotalAmount(Template.instance())

      
