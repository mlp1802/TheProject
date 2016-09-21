{setIdIfEmpty} = require("./misc.coffee")
{isNumber,getPct} = require("./misc.coffee")

copyOrderItem = (i)->
    #setIdIfEmpty(i)
    _id :i._id
    productName:i.productName
    quantity:i.quantity
    amount:i.amount

copyOrderExtra = (extra)->
    _id :extra._id
    name:extra.name
    amount:extra.amount

copyOrderItems = (items)->
    if items is undefined
        []
    else
        items.map(copyOrderItem)

copyOrderExtras = (extras)->
    if extras is undefined
        []
    else
        extras.map(copyOrderExtra)

createOrder =  (o)->
    console.log(o.orderItems)
    order =
      customerId:o.customerId
      customerName:o.customerName
      created_at:new Date()
      orderItems:copyOrderItems(o.orderItems)
      orderExtras:copyOrderExtras(o.orderExtras)
    order.totalAmount = getTotalAmount(order)
    order.status = "not_paid"
    order.currency = "THB"
    order


getAmountForExtra=(amount,value)->
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

getTotalAmount =  (order) ->
   orderItems = order.orderItems
   if orderItems? and orderItems.length > 0
     totalAmount = getTotalAmountForItems(order.orderItems)
     totalAmount = getTotalAmountForExtras(totalAmount,order.orderExtras)
     totalAmount
   else
     0
module.exports = {
    createOrder,
    copyOrderExtras,
    copyOrderExtra,
    copyOrderItems,
    copyOrderItem,
    getTotalAmount,
    getTotalAmountForItems,
    getAmountForExtra,
    isNumber,
    getPct
}
