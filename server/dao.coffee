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

getUser = (id)->
    Meteor.users.findOne({_id:id})
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
        user.profile.isClientOwner = true
        user.profile.isAdmin = true
        user.profile.activated = true
        client = 
                name:user.profile.companyName
                email:user.email
        clientId = Clients.insert(client)
        #create user
        user.profile.clientId = clientId
        Accounts.createUser user



newUser = (user)->
        user.profile.clientId = Meteor.user().profile.clientId
        user.profile.activated = false
        user.profile.isAdmin = false
        user.profile.isClientOwner = false
        Accounts.createUser user

updateProfile = (id,profile)->
        Meteor.users.update(id, {$set: {profile: profile}});
    

activateUser = (userId)->
    profile = (getUser userId).profile
    profile.activated = true
    updateProfile(userId,profile)

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
  newUser,
  activateUser,
  getUser
}

#id = "SzM4cKMgh7k8jGzX6"

#activateUser(id)
#a = getUser(id)
#console.log("LOL A LOL")
#console.log(a)















#