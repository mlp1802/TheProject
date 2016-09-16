Template.OrderList.created = ->
    this.subscribe("orders")

#Template.OrderList.created =

Template.OrderList.helpers(
    orders:->
      Orders.find({},
                sort:
                    created_at:-1
                )
    "eq":(a,b)->a is b
    )
