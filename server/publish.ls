
{Companies} = require("../collections/company.ls")
{Orders} = require("../collections/order.ls")

Meteor.publish("companies", ->Companies.find({}))
Meteor.publish("orders", ->Orders.find({}))
