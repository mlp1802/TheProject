
customers = require "./customers"
orders = require "./orders"
users = require "./users"
getClientId = ->getCurrentUser().clientId
setCurrentUser = (user)->ServerSession.set("currentUser",user)
getCurrentUser = ->ServerSession.get("currentUser")
getCurrentShortUser = ->users.toShortUser(getCurrentUser())
createCompany = (c) ->
    clientId = getClientId()
    customers.createCompany(clientId,c)
    
updateCustomer = (customer)-> customers.updateCustomer(customer)
    
    
newOrder = (order)-> orders.saveNewOrder(getClientId(),order)

allCompanies = -> customers.getAllCompanies(getClientId())
    
newClient = (client,user)->
    result = users.newClient client,user
    if !result.error
        Emails.sendResetEmail client.email,result.resetId
    result
updateOrder = (order)-> Orders.updateOrder(customer)
    
    
updateCurrentProfile = (u)->
    user = getCurrentUser()
    user.firstName = u.firstName
    user.lastName = u.lastName
    user.address = u.address
    users.updateUser(user)
    setCurrentUser(users.getUserByEmail(user.email))
newUser = (user)->
    result = users.newUser getClientId(),user
    if !result.error
        Emails.sendResetEmail user.email,result.resetId
    result

getCurrentUserList = -> users.getUsersByClientId(getClientId())
getCustomersByName =  ->customers.getCustomersByName(users.getClientId())
getCustomersByDate = ->customers.getCustomersByDate(users.getClientId())                
getCustomerById = (id)->  customers.getCustomer(users.getClientId(),id)
    


module.exports = 
    getClientId:getClientId
    setCurrentUser:setCurrentUser
    getCurrentUser:getCurrentUser
    getCurrentShortUser:getCurrentShortUser
    createCompany:createCompany
    updateCustomer:updateCustomer
    newOrder:newOrder
    allCompanies:allCompanies
    newClient:newClient
    updateOrder:updateOrder
    updateCurrentProfile:updateCurrentProfile
    newUser:newUser
    getCurrentUserList:getCurrentUserList
    getCustomersByName:getCustomersByName
    getCustomersByDate:getCustomersByDate

        