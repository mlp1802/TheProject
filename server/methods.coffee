
self = this
methods =
   "createCompany":(company)->
      self.Actions.createCompany(company)
   "updateCustomer":(customer)->
      Actions.updateCustomer(customer)
   "reset":(customer)->
      resetDatabase()
   "saveNewOrder":(order)->
      Actions.newOrder(order)
   "updateOrder":(order)->
      Orders.updateOrder(order)

   "getTotalAmount":(order)->
      Orders.getTotalAmount(order)
   
   "registerClient":(user)->
        Company.registerClient user
        
   
   
   "getUserByEmail":(email)-> Users.getUser(email)
        
   
   "getAllUsers": -> Users.getAllUsers()
   
   "newUser":(user)->
        Actions.newUser user
    "doLogin":(email,password)->
        Users.login email,password
   "activateUser":(id)->
        Actions.activateUser id
   "updateCurrentProfile":(profile)->
        Actions.updateCurrentProfile profile    
   
   "getCurrentUser":->ServerSession.get("currentUser")
   
   "resetCurrentPassword":->
        Dao.resetCurrentPassword()
   "doResetPassword":(id)->
        Dao.resetPassword id
   "getUserList":(clientId)->
        Dao.getUserList(clientId)  
   "getCurrentUserList":->
        Actions.getCurrentUserList()
   "getClientList":->
        Dao.getClientList() 

Meteor.methods(methods)
