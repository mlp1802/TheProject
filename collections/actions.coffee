#

this.Actions = 
    getClientId:->
        ServerSession.get("currentUser").clientId
        

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
        createResult = Users.newClient client,user
        link = "http://localhost:3000/activate/"+createResult.resetId
        body = "Activate your account now please using this link <a href='#{link}'>#{link}</a>"
        email = 
                from:"admin@thesystem.com"
                to:client.email
                subject:"Activate your account"
                html:body
        Email.send email
        createResult.userId
    updateOrder:(order)->
        Orders.updateOrder(customer)
        
    updateCurrentProfile:(profile)->
        
    getCurrentUserList:->
    getCustomersByName: ->
        Company.getCustomersByName(Users.getClientId())
    getCustomersByDate:->
        Company.getCustomersByDate(Users.getClientId())                
    


        
        