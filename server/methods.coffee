Dao = require "./dao"
{getTotalAmount}= require "./orderFunctions"
methods =
  "createCompany":(company)->
      Dao.createCompany(company)
  "updateCustomer":(customer)->
      Dao.updateCustomer(customer)
  "saveNewOrder":(order)->
      Dao.saveNewOrder(order)
  "updateOrder":(order)->
      Dao.updateOrder(order)

  "getCustomersByName":->Dao.getCustomersByName().fetch()


  "getCustomersByDate":->Dao.getCustomersByDate().fetch()

  "getTotalAmount":(order)->
      getTotalAmount(order)




Meteor.methods(methods)
