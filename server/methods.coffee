
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
   
   "registerClient":(client,user)->
        Actions.newClient client,user
        
   
   
   "getUserByEmail":(email)-> Users.getUser(email)
        
   
   "getAllUsers": -> Users.getAllUsers()
   
   "newUser":(user)->
        Actions.newUser user
    "doLogin":(email,password)->
        Users.login email,password
   
   "updateCurrentProfile":(profile)->
        Actions.updateCurrentProfile profile    
   
   "getCurrentUser":->ServerSession.get("currentUser")
   
   "doResetPassword":(token,password)->
      if  !Users.resetPassword token,password 
        throw new Meteor.Error(500, 'Could not reset password', '');
      else
        "reset"
      
      
   
   "getUserList":(clientId)->
        Dao.getUserList(clientId)  
   "getCurrentUserList":->
        Actions.getCurrentUserList()
   "getClientList":->
        Dao.getClientList() 

Meteor.methods(methods)
