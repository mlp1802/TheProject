{Companies} = require("../../collections/company")
{Orders} = require("../../collections/order")
 
getOrder = (id) ->
    Orders.findOne({_id:id})
getOrdersByCustomerName = (name) ->
    #db.users.find({"name": /.*m.*/})
    s = RegExp("^.*"+name+".*$","i")
    Orders.find({customerName:{ $regex: s}})
getCustomer = (id) ->
    Companies.findOne({_id:id})
              
        
getCustomersByName = ->
    Companies.find({},
              sort:
                  name:1
              )


getOrders = ->
  Orders.find({},
            sort:
                created_at:-1
            )

getCustomersByDate=->
    Companies.find({},
              sort:
                  created_at:-1
              )

ClientDao =
    getCustomersByName:getCustomersByName
    getCustomersByDate:getCustomersByDate
    getOrders:getOrders
    getOrder:getOrder
    getCustomer:getCustomer
    getOrdersByCustomerName:getOrdersByCustomerName
    
module.exports =
    ClientDao:ClientDao
        
