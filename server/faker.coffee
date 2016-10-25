{shuffle} = require("./shuffleArray")
{resetDatabase} = require 'meteor/xolvio:cleaner'
createCompany = (c)->
        #console.log(c)
        Company.createCompany(c)
                    
createOrder = (o)->
        #console.log(o)
        Orders.saveNewOrder(o)
        

rnd = -> Math.random()
randomDate = ->if rnd()<0.5 then faker.date.past() else faker.date.future()
randomUpTo = (n)->Math.floor((rnd() * n) + 1);
makerOrderItems = ->
        n = randomUpTo(10)+2
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
    
        

fakeit = ->
    resetDatabase()
    for c in [1..10] 
            fakeCompany()

    for c in [1..100] 
        customers = shuffle(dao.getAllCompanies().fetch().map((x)->x))
        for c in customers
            fakeOrder(c)
#fakeit()
#resetDatabase()
module.exports = 
    fakeit:fakeit    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#