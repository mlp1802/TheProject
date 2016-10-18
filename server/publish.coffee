
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")

Meteor.publish("companies", ->
    if this.userId
        clientId = Meteor.users.find({_id:this.userId}).fetch()[0].profile.clientId
        Companies.find {clientId:clientId})
    
Meteor.publish("orders", ->
    if this.userId
        clientId = Meteor.users.find({_id:this.userId}).fetch()[0].profile.clientId
        Orders.find({clientId:clientId}))
FlowRouter.go("home")

