{setIdIfEmpty} = require("./misc.coffee")
{isNumber,getPct} = require("./misc.coffee")


createOrder =  (order)->
    order.created_at = new Date()
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
    getTotalAmount,
    getTotalAmountForItems,
    getAmountForExtra,
    isNumber,
    getPct
}
