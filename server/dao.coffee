#import {Companies} from "../collections/company.ls"
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")

orderFunctions = require("./orderFunctions")

createCompany = (company)->
  c =
    name:company.name,
    address:company.address,
    created_at:new Date()
  Companies.insert(c)

saveNewOrder =  (o)->
    order = orderFunctions.createOrder(o)
    console.log("NEW ORDER")
    console.log(order)
    order.totalAmount = orderFunctions.getTotalAmount(order)
    Orders.insert(order)

updateCustomer = (customer)->
  Companies.update(
    {_id: customer._id}
    $set:
        name: customer.name
        address: customer.address
    )

updateOrder = (o)->
  Orders.update(
    {_id: o._id}
    $set:
      customerId:o.customerId
      customerName:o.customerName
      created_at:o.created_at
      orderItems:orderFunctions.copyOrderItems(o.orderItems)
      orderExtras:orderFunctions.copyOrderExtras(o.orderExtras)
      totalAmount: orderFunctions.getTotalAmount(o)
      currency:o.currency
      status:o.status
    )

getAllCompanies =->Companies.find({})

getCustomersByName = ->
    Companies.find({},
              sort:
                  name:1
              )

getCustomer=(id)->
    Companies.findOne({_id:id})


getCustomersByDate=->
    Companies.find({},
              sort:
                  created_at:-1
              )

module.exports = {
  createCompany,
  updateCustomer,
  getAllCompanies,
  saveNewOrder,
  updateOrder,
  getCustomersByName,
  getCustomersByDate,
  getCustomer
}
