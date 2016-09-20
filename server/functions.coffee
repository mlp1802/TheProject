
getTotalAmount =  (order) ->
   orderItems = order.orderItems
   if orderItems? and orderItems.length > 0
     order.orderItems.map((item)->Number(item.amount)).reduce((n,m)->n+m)
   else
     0
module.exports =
    Functions:
        getTotalAmount:getTotalAmount
