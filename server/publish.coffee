
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")

Meteor.publish("companies", ->Companies.find({}))
Meteor.publish("orders", ->Orders.find({}))
