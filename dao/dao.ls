
createCompany = (name,address)->
  Companies.insert(
      name:name,
      address:address,
      created_at:new Date()
      )


transformOrderItem = (i)->
    _id:Random.id()
    productName:i.productName
    quantity:i.quantity
    amount:i.amount

newOrder =  (o)->


    order =
      customerId:o.customerId
      customerName:o.customerName
      created_at:new Date()
      orderItems:o.orderItems.map(transformOrderItem)
    order.totalAmount = Functions.getTotalAmount(order)
    order.status = "not_paid"
    order.currency = "THB"
    Orders.insert(order)




updateCustomer = (id,name,address)->
  Companies.update(
    {_id: id}
    $set:
        name: name
        address: address
    )

updateOrder = (o)->
  Orders.update(
    {_id: o._id}
    $set:
      customerId:o.customerId
      customerName:o.customerName
      created_at:o.created_at
      orderItems:o.orderItems.map(transformOrderItem)
      totalAmount: Functions.getTotalAmount(o)
      currency:o.currency
      status:o.status
    )

getAllCompanies =->Mongo.Companies.find({})

Dao =
  createCompany:createCompany
  updateCustomer:updateCustomer
  getAllCompanies:getAllCompanies
  newOrder:newOrder
  updateOrder:updateOrder


this.Dao = Dao
console.log("DAO = "+Dao)
