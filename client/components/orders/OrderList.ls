{ClientDao} = require("../../clientDao/clientDao.ls")
Template.OrderList.created = ->
    this.subscribe("orders")

#Template.OrderList.created =

Template.OrderList.helpers(
    orders:->ClientDao.getOrders()

    "eq":(a,b)->a is b
    )
