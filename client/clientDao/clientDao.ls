{Companies} = require("../../collections/company.ls")
{Orders} = require("../../collections/order.ls")
getCustomersByName = ->
    console.log("BY NAME LOL")
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

module.exports =
    ClientDao:ClientDao
