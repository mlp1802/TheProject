{Dao} = require './dao'
Fiber = Npm.require("fibers")
{chai, assert,expect } = require 'meteor/practicalmeteor:chai'
{resetDatabase} = require 'meteor/xolvio:cleaner'
global.It = it
fiber = (f)->Fiber(f).run()

describe "Dao",
    ->
      beforeEach(->resetDatabase)
      It 'Create Company',
        (done)->
          customer1 =
            name:"ABC"
            address:"USA"
          setTimeout ->
            fiber ->
              id = Dao.createCompany(customer1)
              customer2 = Dao.getCustomer(id)
              assert.equal(customer1.name,customer1.name)
              assert.equal(customer1.address,customer2.address)
              done()
