{Dao} = require "./dao.ls"
methods =
  "createCompany":(name,address)->
      Dao.createCompany(name,address)
  "updateCustomer":(id,name,address)->
      Dao.updateCustomer(id,name,address)
  "newOrder":(order)->
      Dao.newOrder(order)
  "updateOrder":(order)->
      Dao.updateOrder(order)

  "getCustomersByName":->Dao.getCustomersByName().fetch()


  "getCustomersByDate":->Dao.getCustomersByDate().fetch()


  "lol":->
      "LOLZ"


Meteor.methods(methods)
