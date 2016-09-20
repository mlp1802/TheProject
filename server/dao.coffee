#import {Companies} from "../collections/company.ls"
{Companies} = require("../collections/company")
{Orders} = require("../collections/order")
{Functions} = require("./functions")
createCompany = (company)->
  c =
    name:company.name,
    address:company.address,
    created_at:new Date()
  Companies.insert(c)


transformOrderItem = (i)->
    _id:Random.id()
    productName:i.productName
    quantity:i.quantity
    amount:i.amount

newOrder =  (o)->
    getOrderItems = (items)->
        if items is undefined
            []
        else
            items.map(transformOrderItem)

    order =
      customerId:o.customerId
      customerName:o.customerName
      created_at:new Date()
      orderItems:getOrderItems(o.orderItems)
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

Dao =
  createCompany:createCompany
  updateCustomer:updateCustomer
  getAllCompanies:getAllCompanies
  newOrder:newOrder
  updateOrder:updateOrder
  getCustomersByName:getCustomersByName
  getCustomersByDate:getCustomersByDate
  getCustomer:getCustomer

module.exports = {
  Dao:Dao
}
