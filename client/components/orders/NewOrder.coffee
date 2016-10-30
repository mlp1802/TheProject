{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")
getOrderStatus = ->Template.instance().orderStatus.get()
setOrderStatus = (v)-> Template.instance().orderStatus.set(v)
getCurrentOrder = ->Template.instance().currentOrder.get()
setCurrentOrder = (o)->Template.instance().currentOrder.set(o)
getCustomer= () -> 
    customer = Template.instance().data.customer
    console.log("customer")
    console.log(customer)
    customer
        
Template.NewOrder.rendered = ->
        date = getCurrentOrder().paymentDate
        console.log("PAYMENT DATE = "+date)
        getDate = ->
                if date == undefined then new Date() else date
        d = this.$('#thedate')
        d.datepicker
            autoclose:true
        d.datepicker("setDate",getDate())
        
        
      

getSelectedDate = ->
        this.$("#thedate").datepicker("getDate")
        
setupCurrentOrder= ->
  data = Template.instance().data
  order = data.order
  customer = getCustomer()
  if order == undefined
          customerId:customer._id
          customerName:customer.name
          address:customer.address
          orderItems:[]
          paid:false
          orderExtras:[]
  else
          order

togglePaid = ->
      paid = Template.instance().paid
      paid.set(!paid.get())
      order = getCurrentOrder()
      order.paid = paid.get()
      setCurrentOrder(order)
      
updateOrder = ->
        order = getCurrentOrder()
        Meteor.call("updateOrder",order)
        PubSub.publish("orderUpdated",order)
        toastr.success("Order updated","Order")
        
newOrder = ->
        
        order = getCurrentOrder()
        Meteor.call("saveNewOrder",order)
        PubSub.publish("orderCreated",order)
        toastr.success("Order added")
        
saveOrder = (order)->if(order._id==undefined) then newOrder() else updateOrder()


Template.NewOrder.created = ->
  order = setupCurrentOrder()
  this.currentOrder = new ReactiveVar(order)
  this.orderStatus = new ReactiveVar("main")
  this.totalAmount = new ReactiveVar(0)
  this.paid = new ReactiveVar(order.paid)


Template.NewOrder.helpers
  "concat":(a,b)->a+b
  "orderStatus":-> getOrderStatus()
  "eq":(a,b)-> a is b
  "currentOrder":-> getCurrentOrder()
  "totalAmount":->Template.instance().totalAmount.get()
  
  
        
Template.NewOrder.events
  'submit [NewOrder-submitOrder]':(event)->
      event.preventDefault()
      target = event.target
      order = getCurrentOrder()
      order.paymentDate  = getSelectedDate()
      order.address = getAddressFormFields(target)
      saveOrder order
      setOrderStatus("main")
      
  "click [NewOrder-togglePaid]":->togglePaid()
  'click [NewOrder-addOrderItem]':->
      setOrderStatus("orderItem")
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
      setOrderStatus("main")



