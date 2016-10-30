

this.Actions = 
    getClientId:->Actions.getCurrentUser().clientId
    setCurrentUser:(user)->ServerSession.set("currentUser",user)
    getCurrentUser:->ServerSession.get("currentUser")
    createCompany:(c) ->
        clientId = Actions.getClientId()
        Company.createCompany(clientId,c)
        
    updateCustomer:(customer)->
        Company.updateCustomer(customer)
        
    newOrder:(order)->
            Orders.saveNewOrder(Actions.getClientId(),order)

    allCompanies:->
        Company.getAllCompanies(Actions.getClientId())
            
    newClient:(client,user)->
        result = Users.newClient client,user
        if !result.error
            Emails.sendResetEmail client.email,result.resetId
        result
    updateOrder:(order)->
        Orders.updateOrder(customer)
        
    updateCurrentProfile:(u)->
        user = Actions.getCurrentUser()
        user.firstName = u.firstName
        user.lastName = u.lastName
        user.address = u.address
        Users.updateUser(user)
        Actions.setCurrentUser(Users.getUserByEmail(user.email))
    newUser:(user)->
        result = Users.newUser Actions.getClientId(),user
        if !result.error
            Emails.sendResetEmail user.email,result.resetId
        result
    
    getCurrentUserList:->
        Users.getUsersByClientId(Actions.getClientId())

    getCustomersByName: ->
        Company.getCustomersByName(Users.getClientId())
    
    getCustomersByDate:->
        Company.getCustomersByDate(Users.getClientId())                
    


        
        