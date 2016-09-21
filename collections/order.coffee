{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
Orders= new Mongo.Collection("orders")
Orders.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )

module.exports = {
    Orders
    }
