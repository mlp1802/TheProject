{Companies} = require("../../collections/company")
{Orders} = require("../../collections/order")
 
getOrder = (id) ->
    Orders.findOne({_id:id})

searchOrders = (name) ->
    #db.users.find({"name": /.*m.*/})
    s = RegExp("^.*"+name+".*$","i")
    Orders.find(
        {$or:
            [{customerName:{ $regex: s}},{invoiceNumber:{ $regex: s}}]
        },
        
            sort:
                customerName:1
            limit:40
            
            
            )

getOrdersByCustomerId = (id) ->
    Orders.find(
            {customerId:id},
            sort:
                created_at:-1
            limit:40
            )

getCustomer = (id) ->
    Companies.findOne({_id:id})
              
        
getCustomersByName = ->
    Companies.find({},
              sort:
                  name:1
              limit:20
              )


getOrders = ->
  Orders.find({},
            sort:
                created_at:-1
            limit:40
            )

getCustomersByDate=->
    Companies.find({},
              sort:
                  created_at:-1
              limit:20
              )

ClientDao =
    getCustomersByName:getCustomersByName
    getCustomersByDate:getCustomersByDate
    getOrders:getOrders
    getOrder:getOrder
    getCustomer:getCustomer
    getOrdersByCustomerId:getOrdersByCustomerId
    searchOrders:searchOrders
    
module.exports =
    ClientDao:ClientDao
    
        
