{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
Orders= new Mongo.Collection("orders")

this.Orders = 
    getOrder:(id) ->
        Orders.findOne({_id:id})
    
    getOrdersByCustomerId:(id) ->
        Orders.find(
                {customerId:id},
                sort:
                    created_at:-1
                limit:40
                )
    getOrders:  ->
        Orders.find({},
                    sort:
                        created_at:-1
                    limit:40
                    )
    searchOrders:(name) ->
        s = RegExp("^.*"+name+".*$","i")
        Orders.find(
            {$or:
                [{customerName:{ $regex: s}},{invoiceNumber:{ $regex: s}}]
            },
            
                sort:
                    customerName:1
                limit:40
                
                
                )
    saveNewOrder:(clientId,o)->
        order = orderFunctions.createOrder(o)
        order.clientId = clientId
        order.totalAmount = orderFunctions.getTotalAmount(order)
        Orders.insert(order)

    twoDigit: (d) ->
        d=""+d
        if d.length>1
            d
        else
            "0"+d
            
    getInvoiceNumber: ->
        date = new Date()
        d1 = date.getYear()
        d2 = twoDigit(date.getMonth())
        d3 = twoDigit(date.getDate())
        d4 = twoDigit(Orders.find().count())
        d1+d2+d3+d4
        
        
    createOrder:(order)->
        order.created_at = new Date()
        order.invoiceNumber = getInvoiceNumber()
        order.totalAmount = getTotalAmount(order)
        order.status = "not_paid"
        order.currency = "THB"
        order


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
            totalAmount = getAmountForExtra(totalAmount,extra.amount)
        totalAmount

    getTotalAmountForItems:(orderItems)->
        orderItems.map((item)->Number(item.amount)).reduce((n,m)->n+m)

    getTotalAmount:(order) ->
        orderItems = order.orderItems
        if orderItems? and orderItems.length > 0
            totalAmount = getTotalAmountForItems(order.orderItems)
            totalAmount = getTotalAmountForExtras(totalAmount,order.orderExtras)
            totalAmount
        else
            0
    updateOrder:(order)->
        order.totalAmount = orderFunctions.getTotalAmount(order)      
        Orders.update order._id,order



