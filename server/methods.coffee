Dao = require "./dao"
Actions = require "./actions"
{getTotalAmount}= require "./orderFunctions"
methods =
   "createCompany":(company)->
      Actions.createCompany(company)
   "updateCustomer":(customer)->
      Actions.updateCustomer(customer)
   "saveNewOrder":(order)->
      Actions.newOrder(order)
   "updateOrder":(order)->
      Dao.updateOrder(order)

   "getTotalAmount":(order)->
      getTotalAmount(order)
   
   "registerClient":(user)->
        Dao.registerClient user
        
   "newUser":(user)->
        Actions.newUser user
   "activateUser":(id)->
        Actions.activateUser id

Meteor.methods(methods)
