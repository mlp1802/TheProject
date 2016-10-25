instance =  ->Template.instance()
getSelectedId = ->instance().selectedOrderId.get()
setSelectedId = (id)->instance().selectedOrderId.set(id)
isSelected = ->getSelectedId()!=undefined

getPaymentClass =(order) ->
    if(order.paid) 
        "success"
    else
        if new Date()>order.paymentDate and  !order.paid
            "danger"
        else
            "info"
        
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

Template.OrderList.helpers
    "isSelected":(id)->isSelected()
    "selectedId":->getSelectedId()
    "selectedOrder":->Orders.getOrder(getSelectedId())
    "getClass":(order)->getPaymentClass order
        

Template.OrderList.events
    "click [OrderList-closeOrder]":(event)->
        setSelectedId(undefined)
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        setSelectedId(selectedId)
        #Meteor.setTimeout((->$(window).scrollTop($("#OrderList-NewOrder").offset().top-600)),100)
        
        
    
