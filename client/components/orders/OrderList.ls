Template.OrderList.created = ->
    this.subscribe("orders")

Template.OrderList.helpers(
    orders:->Orders.find({})
    )
