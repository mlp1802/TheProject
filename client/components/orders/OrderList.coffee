{ClientDao} = require("../../clientDao/clientDao")
instance =  ->Template.instance()
getSelectedId = ->Template.instance().selectedOrderId.get()
setSelectedId = (id)->Template.instance().selectedOrderId.set(id)
setPrevSelectedId = (id)->Template.instance().prevSelectedOrderId.set(id)
getPrevSelectedId = ->Template.instance().prevSelectedOrderId.get()
isSelected = ->getSelectedId()!=undefined
getSelectedYPos = ->instance().selectedYPos.get()
setSelectedYPos = (y)->instance().selectedYPos.set(y)
Template.OrderList.created = ->
    this.selectedOrderId = new ReactiveVar()
    this.prevSelectedOrderId = new ReactiveVar()
    this.subscribe("orders")
    this.selectedYPos = new ReactiveVar()
    selId = this.selectedOrderId
    selYPos = this.selectedYPos
    PubSub.subscribe "orderUpdated",->
        el = "#OrderList-orderRow_"+selId.get()
        selId.set(undefined)
        y = selYPos.get()
        console.log("SELECTED Y ="+y)
        Meteor.setTimeout((->$(window).scrollTop($(el).offset().top-y)),10)
        
        
              
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
        pos = $("#OrderList-orderRow_"+selectedId)[0].getBoundingClientRect()
        setSelectedYPos(pos.top)
        #$(window).scrollTop( $(el).offset().top-100);
        #0console.log("CLICKED ROW "+event.currentTarget.attributes["OrderList-orderRow"].value)
        
        
    
