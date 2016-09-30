{ClientDao} = require("../../clientDao/clientDao")
instance =  ->Template.instance()
getSelectedId = ->instance().selectedOrderId.get()
setSelectedId = (id)->instance().selectedOrderId.set(id)
setPrevSelectedId = (id)->instance().prevSelectedOrderId.set(id)
getPrevSelectedId = ->instance().prevSelectedOrderId.get()
isSelected = ->getSelectedId()!=undefined
reposition = (id,y)->
        el = "#OrderList-orderRow_"+id
        console.log("EL = "+el+" Y="+y)
        
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
        Meteor.setTimeout((->$(window).scrollTop($("#OrderList-NewOrder").offset().top-600)),100)
        
        
    
