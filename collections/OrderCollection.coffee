{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
OrderCollection= new Mongo.Collection("orders")

this.Orders = 
    getOrder:(id) ->
        OrderCollection.findOne({_id:id})
    
    getOrdersByClientId:(clientId) ->
        OrderCollection.find(
                {clientId:clientId},
                sort:
                    created_at:-1
                limit:40
                )
    getOrdersByCustomerId:(id) ->
        OrderCollection.find(
                {customerId:id},
                sort:
                    created_at:-1
                limit:40
                )
    getOrders:  ->
        OrderCollection.find({},
                    sort:
                        created_at:-1
                    limit:40
                    )
    searchOrders:(name) ->
        s = RegExp("^.*"+name+".*$","i")
        OrderCollection.find(
            {$or:
                [{customerName:{ $regex: s}},{invoiceNumber:{ $regex: s}}]
            },
            
                sort:
                    customerName:1
                limit:40
                
                
                )
    createOrder:(order)->
        order.created_at = new Date()
        order.invoiceNumber = Orders.getInvoiceNumber()
        order.totalAmount = Orders.getTotalAmount(order)
        order.status = "not_paid"
        order.currency = "THB"
        order

    saveNewOrder:(clientId,o)->
        order = Orders.createOrder(o)
        order.clientId = clientId
        order.totalAmount = Orders.getTotalAmount(order)
        OrderCollection.insert(order)

    twoDigit: (d) ->
        d=""+d
        if d.length>1
            d
        else
            "0"+d
            
    getInvoiceNumber: ->
        date = new Date()
        d1 = date.getYear()
        d2 = Orders.twoDigit(date.getMonth())
        d3 = Orders.twoDigit(date.getDate())
        d4 = Orders.twoDigit(OrderCollection.find().count())
        d1+d2+d3+d4
        
        
    


    getAmountForExtra:(amount,value)->
        if isNumber(value)
            amount+Number(value)
        else
            if value.includes("%")
                pct = getPct(value)/100.0
                amount+amount*pct
            else
            amount


    getTotalAmountForExtras:(totalAmount,extras)->
        for extra in extras
            totalAmount = Orders.getAmountForExtra(totalAmount,extra.amount)
        totalAmount

    getTotalAmountForItems:(orderItems)->
        orderItems.map((item)->Number(item.amount)).reduce((n,m)->n+m)

    getTotalAmount:(order) ->
        orderItems = order.orderItems
        if orderItems? and orderItems.length > 0
            totalAmount = Orders.getTotalAmountForItems(order.orderItems)
            totalAmount = Orders.getTotalAmountForExtras(totalAmount,order.orderExtras)
            totalAmount
        else
            0
    updateOrder:(order)->
        order.totalAmount = Orders.getTotalAmount(order)      
        OrderCollection.update order._id,order



