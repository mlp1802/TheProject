{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")

Clients = new Mongo.Collection("clients")
Clients.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )

module.exports =
    {
    Clients
    }
