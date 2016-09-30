{ClientDao} = require("../../clientDao/clientDao")
getSelectedId = ->Template.instance().selectedOrderId.get()
setSelectedId = (id)->Template.instance().selectedOrderId.set(id)
setPrevSelectedId = (id)->Template.instance().prevSelectedOrderId.set(id)
getPrevSelectedId = ->Template.instance().prevSelectedOrderId.get()
isSelected = ->getSelectedId()!=undefined
Template.OrderList.created = ->
    this.selectedOrderId = new ReactiveVar()
    this.prevSelectedOrderId = new ReactiveVar()
    this.subscribe("orders")
    sel = this.selectedOrderId
    PubSub.subscribe "orderUpdated",->
        el = "#OrderList-orderRow_"+sel.get()
        sel.set(undefined)
        
        $(window).scrollTop( $(el).offset().top-500);
        
              
Template.OrderList.helpers
    #orders:->Template.instance().orders
    "isSelected":(id)->isSelected()
    "selectedId":->getSelectedId()
    "prevSelectedId":->getPrevSelectedId()
    "selectedOrder":->ClientDao.getOrder(getSelectedId())
    "getSelectedClass":(orderId)->
        if not isSelected() and orderId == getPrevSelectedId()
                    "success"
                else
                    ""
            
        
    
Template.OrderList.events
    "click [OrderList-closeOrder]":(event)->
        setSelectedId(undefined)
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        setSelectedId(selectedId)
        setPrevSelectedId(selectedId)
        el = "#OrderList-orderRow_"+selectedId
        $(window).scrollTop( $(el).offset().top-100);
        #0console.log("CLICKED ROW "+event.currentTarget.attributes["OrderList-orderRow"].value)
        
        
    
