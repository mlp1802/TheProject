getTotalAmount = ->
  Functions.getTotalAmount(Template.instance().data.order)


Template.OrderItems.created =
    ->
      order = Template.instance().data.order
      this.totalAmount = new ReactiveVar(Template.instance().data.totalAmount)
      this.getOrderItems = new ReactiveVar(order.orderItems)
      Tracker.autorun(->this.totalAmount.set getTotalAmount())



Template.OrderItems.helpers (
    "getOrderItems":->Template.instance().getOrderItems.get()
    "totalAmount":->Template.instance().totalAmount.get()
    "eq":(a,b)->a is b
    )

Template.OrderItems.events (

    "click [removeOrderItem]":(event)->
        id = event.target.value
        orderItems = this.order.orderItems
        newItems = orderItems.filter((item)->item._id!=id)
        orderItems.splice(0, orderItems.length)
        newItems.forEach((item)->orderItems.push(item))
        Template.instance().getOrderItems.set(orderItems)
        Template.instance().totalAmount.set(getTotalAmount())
        #console.log("CLICKED "+event.target.value)

)
