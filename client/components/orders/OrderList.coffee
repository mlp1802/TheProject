clientDao = require("../../queries")
self
instance =  ->Template.instance()
getSelectedOrder = ->instance().selectedOrder.get()
setSelectedOrder = (id)->instance().selectedOrder.set(id)
isSelected = ->getSelectedOrder()!=undefined

getPaymentClass =(order) ->
    if(order.paid)
        "success"
    else
        if new Date()>order.paymentDate and  !order.paid
            "danger"
        else
            "info"

Template.OrderList.created = ->
    self = this
    this.selectedOrder = new ReactiveVar()
    selected = this.selectedOrder
    PubSub.subscribe "orderUpdated",->
        selected.set(undefined)

Template.OrderList.helpers
    "isSelected":(id)->isSelected()
    "selectedId":->getSelectedId()
    "selectedOrder":->getSelectedOrder()
    "getClass":(order)->getPaymentClass order


Template.OrderList.events
    "click [OrderList-closeOrder]":(event)->
        setSelectedOrder(undefined)
    "click [OrderList-orderRow]":(event)->
        selectedId = event.currentTarget.attributes["OrderList-orderRow"].value
        self = Template.instance()
        clientDao.getOrder selectedId,(error,order)->
        		console.log("GOT ORDER for id "+selectedId)
        		console.log order
        		self.selectedOrder.set order

        #setSelectedId(selectedId)
        #Meteor.setTimeout((->$(window).scrollTop($("#OrderList-NewOrder").offset().top-600)),100)
