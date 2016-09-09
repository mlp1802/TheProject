createCompany = (name,address)->
  Companies.insert(
      name:name,
      address:address,
      created_at:new Date()
      )

newOrder =  (order)->
    Orders.insert(
      customerId:order.customerId
      productName:order.productName
      amount:order.amount
      quantity:order.quantity
    )
updateCustomer = (id,name,address)->
  Companies.update(
    {_id: id}
    $set:
        name: name
        address: address
    )

getAllCompanies =->Mongo.Companies.find({})

Dao =
  createCompany:createCompany
  updateCustomer:updateCustomer
  getAllCompanies:getAllCompanies


this.Dao = Dao
console.log("DAO = "+Dao)
