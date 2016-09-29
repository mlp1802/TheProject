{ClientDao} = require("../../clientDao/clientDao")
getSelectedId = ->Template.instance().selectedOrderId.get()
setSelectedId = (id)->Template.instance().selectedOrderId.set(id)
Template.OrderList.created = ->
    this.selectedOrderId = new ReactiveVar()
    this.subscribe("orders")
    sel = this.selectedOrderId
    PubSub.subscribe("orderUpdated",->sel.set(undefined))
              
              

Template.OrderList.helpers
    orders:->ClientDao.getOrders()
    
    "isSelected":(id)->getSelectedId()!=undefined
    "selectedId":->getSelectedId()
    "selectedOrder":->
        order = ClientDao.getOrder(getSelectedId())
        console.log(order)
        order
    
Template.OrderList.events
    "click [OrderList-closeOrder]":(event)->
        setSelectedId(undefined)
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        setSelectedId(selectedId)
        #console.log("CLICKED ROW "+event.currentTarget.attributes["OrderList-orderRow"].value)
        
        
    
