#

this.Actions = 
    getClientId:->
        ServerSession.get("currentUser").clientId
        

    createCompany:(c) ->
        clientId = Actions.getClientId()
        console.log("CREATING COMPANIES for client "+clientId)
        Company.createCompany(clientId,c)
        
    updateCustomer:(customer)->
        Company.updateCustomer(customer)
        
    newOrder:(order)->
            Orders.saveNewOrder(Actions.getClientId(),order)

    allCompanies:->
        Company.getAllCompanies(Actions.getClientId())
            
    newUser:(user)->
        Users.newUser Meteor.user().profile.clientId,user
    updateOrder:(order)->
        Orders.updateOrder(customer)
        
    
    updateCurrentProfile:(profile)->
        
    getCurrentUserList:->
    getCustomersByName: ->
        Company.getCustomersByName(Users.getClientId())
    getCustomersByDate:->
        Company.getCustomersByDate(Users.getClientId())                
    


        
        