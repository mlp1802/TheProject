
Meteor.publish("orders", ->
    return Orders.find({})
    )
