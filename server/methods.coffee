Actions = require "./actions"
Users = require "./users"
Customer = require "./customers"
Orders = require "./orders"
self = this
methods =
    "createCompany":(company)->
      Actions.createCompany(company)
    "updateCustomer":(customer)->
      Actions.updateCustomer(customer)
    "reset":(customer)->
      resetDatabase()
    "saveNewOrder":(order)->
      Actions.newOrder(order)

    "getCustomersByName":->
        Actions.getCustomersByName().fetch()

    "getCustomerById":(id)->
        Customer.getCustomer(id)


    "getTotalAmount":(order)->
      Orders.getTotalAmount(order)

    "searchOrders":(name)->
        orders = (Actions.searchOrders name).fetch()
        orders


    "registerClient":(client,user)->
        Actions.newClient client,user

    "getUserByEmail":(email)-> Users.getUserByEmail(email)

    #Orders
    "updateOrder":(order)->
      Orders.updateOrder(order)

    "getOrder":(id)->Orders.getOrder id


    "getOrders": ->
    	Actions.getOrders().fetch()
    "getOrdersByCustomerId":(id)->
        (Orders.getOrdersByCustomerId id).fetch()


    "getAllUsers": -> Users.getAllUsers().fetch()

    "newUser":(user)->
        result = Actions.newUser user
        if !result.error
          {
            error:false
            message:"User created"
          }
        else
          result


    "doLogin":(email,password)->
        Users.login email,password


    "doLogout":(email,password)->
        ServerSession.set("currentUser",null)

    "updateCurrentProfile":(profile)->
        Actions.updateCurrentProfile profile

    "getCurrentUser":->ServerSession.get("currentUser")

    "doResetPassword":(token,password)->
      if  !Users.resetPassword token,password
        throw new Meteor.Error(500, 'Could not reset password', '');
      else
        "reset"


    "getCurrentUserList":->
        Actions.getCurrentUserList().fetch()


    "getClientList":->
        Actions.getClientList()

Meteor.methods(methods)
