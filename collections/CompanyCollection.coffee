{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")

Companies= new Mongo.Collection("companies")

this.Company = 
    getCustomer:(id) ->
        Companies.findOne({_id:id})
    
    
    
    createCompany:(clientId,company)->
        company.clientId = clientId    
        company.created_at = new Date()
        Companies.insert(company)

    updateCustomer:(customer)->
        Companies.update({_id:customer._id},customer)
    
    getAllCompanies:(clientId)->Companies.find({clientId:clientId})

    all:(clientId)->Companies.find()
    


    getCustomer:(id)->
        Companies.findOne({_id:id})

    getCustomersByName:(clientId)->
        Companies.find {clientId:clientId},
            sort:
                name:1
    
    getCustomersByDate:(clientId)->
        Companies.find({clientId:clientId},
                sort:
                    created_at:-1
                )
