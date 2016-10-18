#import {Companies} from "../collections/company.ls"
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")
{Clients} = require("../collections/order")

orderFunctions = require("./orderFunctions")

createCompany = (clientId,company)->
  company.clientId = clientId    
  company.created_at = new Date()
  Companies.insert(company)


saveNewOrder =  (clientId,o)->
    order = orderFunctions.createOrder(o)
    order.clientId = clientId
    order.totalAmount = orderFunctions.getTotalAmount(order)
    Orders.insert(order)

updateCustomer = (customer)->
    Companies.update({_id:customer._id},customer)
   
updateOrder = (order)->
  order.totalAmount = orderFunctions.getTotalAmount(order)      
  Orders.update order._id,order
    

getAllCompanies =(clientId)->Companies.find({clientId:clientId})

getCustomersByName = (clientId)->
    Companies.find({clientId:clientId},
              sort:
                  name:1
              )

getCustomer=(id)->
    Companies.findOne({_id:id})


getCustomersByDate=(clientId)->
    Companies.find({},
              sort:
                  created_at:-1
              )

registerClient  = (user) ->
        user.profile.isClient = true
        user.profile.clientId = Random.id()
        Accounts.createUser(user)
        
                        

module.exports = {
  createCompany,
  updateCustomer,
  getAllCompanies,
  saveNewOrder,
  updateOrder,
  getCustomersByName,
  getCustomersByDate,
  getCustomer,
  registerClient
  
}

















#