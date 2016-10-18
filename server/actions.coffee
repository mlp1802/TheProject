#
Dao = require "./dao"
getClientId = ->
    Meteor.user().profile.clientId

createCompany = (c) ->
    clientId = getClientId()
    Dao.createCompany(clientId,c)
    
updateCustomer = (customer)->
    Dao.updateCustomer(customer)
    
newOrder = (order)->
        Dao.saveNewOrder(getClientId(),order)
        
        
        

allCompanies = ->
    Dao.getAllCompanies(getClientId())
        
updateOrder = (order)->
    Dao.updateOrder(customer)
    
module.exports =  {
    createCompany,
    allCompanies,
    updateCustomer,
    updateOrder,
    newOrder
    
    
}
        
        