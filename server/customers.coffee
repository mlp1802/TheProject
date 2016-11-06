{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")

Customers = new Mongo.Collection("customers")

getCustomer = (id) ->
    Customers.findOne({_id:id})


createCompany = (clientId,company)->
    company.clientId = clientId    
    company.created_at = new Date()
    Customers.insert(company)

updateCustomer = (customer)->
    Customers.update({_id:customer._id},customer)

getAllCompanies = (clientId)->Customers.find({clientId:clientId})

all = (clientId)->Customers.find()



getCustomersByName = (clientId)->
    Customers.find {clientId:clientId},
        sort:
            name:1

getCustomersByDate = (clientId)->
    Customers.find({clientId:clientId},
            sort:
                created_at:-1
            )

module.exports = 
    getCustomer:getCustomer
    createCompany:createCompany
    updateCustomer:updateCustomer
    getAllCompanies:getAllCompanies
    all:all
    getCustomer:getCustomer
    getCustomersByName:getCustomersByName
    getCustomersByDate:getCustomersByDate
        
