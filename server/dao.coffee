#import {Companies} from "../collections/company.ls"
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")
{Clients} = require("../collections/client")

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
        #create client
        user.profile.isClient = true
        user.profile.isAmin = true
        client = 
                name:user.profile.companyName
        clientId = Clients.insert(client)
        #create user
        user.profile.clientId = clientId
        insertUser user
        
insertUser = (user)->
        user.profile.activated = false
        Accounts.createUser user 

newUser = (user)->
        user.profile.clientId = Meteor.user().profile.clientId
        insert user

updateProfile = (profile)->
        Meteor.users.update(Meteor.userId(), {$set: {profile: profile}});
    


module.exports = {
  createCompany,
  updateCustomer,
  getAllCompanies,
  saveNewOrder,
  updateOrder,
  getCustomersByName,
  getCustomersByDate,
  getCustomer,
  registerClient,
  updateProfile,
  newUser
}

















#