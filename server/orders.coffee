{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
Startup = require("./startup")
Listeners = require("./listeners")
OrderCollection = new Mongo.Collection("orders")

getOrder = (id) -> OrderCollection.findOne({_id:id})

getOrdersByClientId = (clientId) ->
    OrderCollection.find(
            {clientId:clientId},
            sort:
                created_at:-1
            limit:40
            )
getOrdersByCustomerId = (id) ->
    OrderCollection.find(
            {customerId:id},
            sort:
                created_at:-1
            limit:40
            )
getOrders = ->
    OrderCollection.find({},
                sort:
                    created_at:-1
                limit:40
                )
searchOrders = (clientId,name) ->
    s = RegExp("^.*"+name+".*$","i")
    OrderCollection.find(
        {$and:
          [
              {clientId:clientId},
              {$or:
                  [{customerName:{ $regex: s}},{invoiceNumber:{ $regex: s}}]
              }

          ]
        }
        ,

            sort:
                customerName:1
            limit:40


            )
createOrder = (order)->
    order.created_at = new Date()
    order.invoiceNumber = getInvoiceNumber()
    order.totalAmount = getTotalAmount(order)
    order.status = "not_paid"
    order.currency = "THB"
    order

saveNewOrder = (clientId,o)->
    order = createOrder(o)
    order.clientId = clientId
    order.totalAmount = getTotalAmount(order)
    OrderCollection.insert(order)

twoDigit = (d) ->
    d=""+d
    if d.length>1
        d
    else
        "0"+d

getInvoiceNumber = ->
    date = new Date()
    d1 = date.getYear()
    d2 = twoDigit(date.getMonth())
    d3 = twoDigit(date.getDate())
    d4 = twoDigit(OrderCollection.find().count())
    d1+d2+d3+d4

getAmountForExtra = (amount,value)->
    if isNumber(value)
        amount+Number(value)
    else
        if value.includes("%")
            pct = getPct(value)/100.0
            amount+amount*pct
        else
        amount

getTotalAmountForExtras = (totalAmount,extras)->
    for extra in extras
        totalAmount = getAmountForExtra(totalAmount,extra.amount)
    totalAmount

getTotalAmountForItems = (orderItems)->
    orderItems.map((item)->Number(item.amount)).reduce((n,m)->n+m)

getTotalAmount = (order) ->
    orderItems = order.orderItems
    if orderItems? and orderItems.length > 0
        totalAmount = getTotalAmountForItems(order.orderItems)
        totalAmount = getTotalAmountForExtras(totalAmount,order.orderExtras)
        totalAmount
    else
        0
updateOrder = (order)->
    order.totalAmount = getTotalAmount(order)
    OrderCollection.update order._id,order

module.exports =
    getOrder:getOrder
    getOrdersByClientId:getOrdersByClientId
    getOrdersByCustomerId:getOrdersByCustomerId
    getOrders:getOrders
    searchOrders:searchOrders
    createOrder:createOrder
    saveNewOrder:saveNewOrder
    twoDigit:twoDigit
    getInvoiceNumber:getInvoiceNumber
    getAmountForExtra:getAmountForExtra
    getTotalAmountForExtras:getTotalAmountForExtras
    getTotalAmountForItems:getTotalAmountForItems
    getTotalAmount:getTotalAmount
    updateOrder:updateOrder

#Ad order events


Startup.addStartAction ->
        Listeners.addOrderCreatedListener (order)->
                EventLog.orderCreated(order)
