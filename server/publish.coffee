


Meteor.publish "companies", ->
        Company.getAllCompanies(Users.getClientId())
    
Meteor.publish("orders", ->
    clientId = Users.getClientId()
    Orders.find({clientId:clientId}))
FlowRouter.go("home")

