Orders= new Mongo.Collection("orders")
Orders.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )

module.exports =
    "Orders":Orders
