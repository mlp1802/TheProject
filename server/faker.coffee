dao = require("./dao")
{resetDatabase} = require 'meteor/xolvio:cleaner'
createCompany = (c)->
        #console.log(c)
        dao.createCompany(c)
                    
createOrder = (o)->
        #console.log(o)
        dao.saveNewOrder(o)
        
        

rnd = -> Math.random()
randomDate = ->if rnd<0.5 then faker.date.past() else faker.date.future()
randomUpTo = (n)->Math.floor((rnd() * n) + 1);
makerOrderItems = ->
        n = randomUpTo(10)
        [0..n].map((x)->makeOrderItem())

makeOrderItem = ()->
        quantity = randomUpTo(10)
        amount = randomUpTo(20)*quantity
        orderItem = 
            _id:Random.id()
            productName:faker.commerce.productName()
            quantity:quantity
            amount:amount
        orderItem

fakeOrder = (company)->
        order =
            customerId:company._id
            customerName:company.name
            paymentDate:randomDate()
            address:company.address
            paid:rnd<0.5
            orderItems:makerOrderItems()
            orderExtras:[]
        createOrder(order)    
fakeCompany = ()->
    company = 
        name:faker.company.companyName()
        address:
            address1:faker.address.streetName()
            address2:randomUpTo(200)
            address3:""
            country:faker.address.country()
            zip:faker.address.zipCode()
    createCompany(company)
    
        

fakeOrdersForCompany =(company)->
    for x in [0..randomUpTo(4)]
        fakeOrder(company)
fakeit = ->
    
    resetDatabase()
    for c in [1..5]
            fakeCompany()
    
    customers = dao.getAllCompanies()
    for c in customers.fetch()
        fakeOrdersForCompany(c)
#fakeit()
module.exports = 
    fakeit:fakeit    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#