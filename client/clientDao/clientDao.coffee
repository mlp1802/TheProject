{Companies} = require("../../collections/company")
{Orders} = require("../../collections/order")
 
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
    getCustomer:getCustomer
    
module.exports =
    ClientDao:ClientDao
        
