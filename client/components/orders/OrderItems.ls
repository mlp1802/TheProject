getTotalAmount = ->
   Template.instance().data.orderItems.map((item)~>Number(item.amount)).reduce((n,m)->n+m)


Template.OrderItems.created =
    ->
      orderItems = Template.instance().data.orderItems
      this.totalAmount = new ReactiveVar(Template.instance().data.totalAmount)
      this.getOrderItems = new ReactiveVar(orderItems)
      Tracker.autorun(~>this.totalAmount.set getTotalAmount())



Template.OrderItems.helpers (
    "getOrderItems":->Template.instance().getOrderItems.get()
    "totalAmount":->Template.instance().totalAmount.get()
    "eq":(a,b)->a is b
    )

Template.OrderItems.events (

    "click [removeOrderItem]":(event)->
        id = event.target.value
        newItems = this.orderItems.filter((item)->item._id!=id)

        this.orderItems.splice(0, this.orderItems.length)
        newItems.forEach((item)~>item.name="skod")
        newItems.forEach((item)~>this.orderItems.push(item))
        Template.instance().getOrderItems.set(this.orderItems)
        Template.instance().totalAmount.set(getTotalAmount())
        #console.log("CLICKED "+event.target.value)

)
