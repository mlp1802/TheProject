

methods =
  "createCompany":(name,address)->
      Dao.createCompany(name,address)
  "updateCustomer":(id,name,address)->
      Dao.updateCustomer(id,name,address)
  "newOrder":(order)->
      Dao.newOrder(order)

Meteor.methods(methods)
