#import {Companies} from "../collections/company.ls"
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")

orderFunctions = require("./orderFunctions")

createCompany = (company)->
  company.created_at = new Date()
  Companies.insert(company)


        
saveNewOrder =  (o)->
    order = orderFunctions.createOrder(o)
    order.totalAmount = orderFunctions.getTotalAmount(order)
    Orders.insert(order)

updateCustomer = (customer)->
  Companies.update({_id:customer._id},customer)
   
updateOrder = (order)->
  order.totalAmount = orderFunctions.getTotalAmount(order)      
  Orders.update order._id,order
    

getAllCompanies =->Companies.find({})

getCustomersByName = ->
    Companies.find({},
              sort:
                  name:1
              )

getCustomer=(id)->
    Companies.findOne({_id:id})


getCustomersByDate=->
    Companies.find({},
              sort:
                  created_at:-1
              )

module.exports = {
  createCompany,
  updateCustomer,
  getAllCompanies,
  saveNewOrder,
  updateOrder,
  getCustomersByName,
  getCustomersByDate,
  getCustomer
}
