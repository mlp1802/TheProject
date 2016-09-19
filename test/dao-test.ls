chai = require 'chai'
assert = chai.assert
expect = chai.expect
sinonChai = require("sinon-chai")
CollectionMock = require("./meteorMock").CollectionMock
sinon = require "sinon"
console.log(CollectionMock)
chai.use sinonChai
chai.should()
{Dao} = require '../server/dao'
global.It = it
describe "CreateCompany",
    ->
      It 'Calls insert',sinon.test ->
        save = this.spy(CollectionMock,"insert")
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
