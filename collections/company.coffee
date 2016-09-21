{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")

Companies= new Mongo.Collection("companies")
Companies.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )

module.exports =
    {
    Companies
    }
