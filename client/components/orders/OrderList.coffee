{ClientDao} = require("../../clientDao/clientDao")
instance =  ->Template.instance()
getSelectedId = ->instance().selectedOrderId.get()
setSelectedId = (id)->instance().selectedOrderId.set(id)
setPrevSelectedId = (id)->instance().prevSelectedOrderId.set(id)
getPrevSelectedId = ->instance().prevSelectedOrderId.get()
isSelected = ->getSelectedId()!=undefined
getSelectedYPos = ->instance().selectedYPos.get()
setSelectedYPos = (y)->instance().selectedYPos.set(y)
reposition = (id,y)->
        el = "#OrderList-orderRow_"+id
        console.log("EL = "+el+" Y="+y)
        Meteor.setTimeout((->$(window).scrollTop($(el).offset().top-y)),500)
        
Template.OrderList.created = ->
    this.selectedOrderId = new ReactiveVar()
    this.prevSelectedOrderId = new ReactiveVar()
    this.subscribe("orders")
    this.selectedYPos = new ReactiveVar()
    id = this.selectedOrderId
    y = this.selectedYPos
    PubSub.subscribe "orderUpdated",->
        i = id.get()
        id.set(undefined)
        console.log("ORDER UPDATED")
        reposition(i,y.get())
        
        
              
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
        reposition(getPrevSelectedId(),getSelectedYPos())
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        setSelectedId(selectedId)
        setPrevSelectedId(selectedId)
        pos = $("#OrderList-orderRow_"+selectedId)[0].getBoundingClientRect()
        setSelectedYPos(pos.top)
        Meteor.setTimeout((->$(window).scrollTop($("#OrderList-NewOrder").offset().top-600)),100)
        #$(window).scrollTop( $(el).offset().top-100);
        #0console.log("CLICKED ROW "+event.currentTarget.attributes["OrderList-orderRow"].value)
        
        
    
