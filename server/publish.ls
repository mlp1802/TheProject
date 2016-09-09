
Meteor.publish("companies", ->Companies.find({}))
Meteor.publish("orders", ->Orders.find({}))
