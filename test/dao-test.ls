chai = require 'chai'
assert = chai.assert
expect = chai.expect
sinonChai = require("sinon-chai")
chai.use sinonChai
sinon = require "sinon"
td = require 'testdouble';
Meteor = td.object(["methods", "call"])
chai.should()
CallMock =
    insert:(a)->
    update:(a)->

class Collection
    (@name)->
    allow:(a)->
    insert:(a)->CallMock.insert(a)
    update:(a)->CallMock.update(a)

Mongo =
    Collection:Collection
td.replace("meteor/meteor", { Meteor })
td.replace("meteor/mongo", { Mongo})
{Dao} = require '../server/dao'
global.It = it
describe "CreateCompany",
    ->
      It 'Calls insert',sinon.test ->
            save = this.spy(CallMock,"insert")
            Dao.newOrder(
              {
                customerId:"cust_id"
                customerName:"bob"
                orderItems:[]
              })
            save.should.have.callCount(1)
            args = save.getCall(0).args
            order = args[0]
            expect(args.length).to.equal(1)
            expect(order.status).to.equal("not_paid")
            expect(order.totalAmount).to.equal(0)
            expect(order.customerName).to.equal("bob")
            expect(order.customerId).to.equal("cust_id")
            expect(save).to.have.callCount(1)
