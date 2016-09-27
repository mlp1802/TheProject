{ClientDao} = require("../../clientDao/clientDao")
subscribeToOrderUpdated = (msg,order)->
   this.$("#closeOrder_"+order._id).click()

Template.OrderList.created = ->
    this.selectedOrder = new ReactiveVar()
    this.subscribe("orders")
    PubSub.subscribe("orderUpdated",subscribeToOrderUpdated)
              
              
Template.OrderList.helpers
    orders:->ClientDao.getOrders()
    "eq":(a,b)->a is b
    "isSelected":(id)->id == Template.instance().selectedOrder.get()    

Template.OrderList.events
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        Template.instance().selectedOrder.set(selectedId)
        #console.log("CLICKED ROW "+event.currentTarget.attributes["OrderList-orderRow"].value)
        
        
    
