this.Orders= new Mongo.Collection("orders")
this.Orders.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )
