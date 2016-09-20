f = require '../server/functions'
Functions = f.Functions
chai = require("chai")
chaiSubset = require('chai-subset');
chai.use(chaiSubset)
assert = chai.assert
expect = chai.expect

sinonChai = require("sinon-chai")
CollectionMock = require("./meteorMock").CollectionMock
sinon = require "sinon"
{Dao} = require '../server/dao'
chai.use sinonChai
chai.should()
describe "NewOrder",
    ->
      it 'Calls insert',sinon.test ->
        save = this.spy(CollectionMock,"insert")
        order  =
                  customerId:"cust_id"
                  customerName:"bob"
                  orderItems:[]
        Dao.newOrder(order)
        save.should.have.callCount(1)
        args = save.getCall(0).args
        newOrder = args[0]
        expect(args.length).to.equal(1)
        expect(newOrder.status).to.equal("not_paid")
        expect(newOrder.totalAmount).to.equal(0)
        expect(newOrder.created_at).to.not.equal(undefined)
        expect(newOrder).to.containSubset(order)



describe "Price calculation",
  ->
      it "Gets Total Amount",
        sinon.test ->
            orderItems =
                [
                  {
                  "amount":20
                  }
                  {
                  "amount":25
                  }
                ]
            order =
                orderItems:orderItems
            total = Functions.getTotalAmount(order)
            expect(total).to.equal(45)

      it "Returns zero when empty order items arays",
        sinon.test ->
            order =
                orderItems:[]
            expect(Functions.getTotalAmount(order)).to.equal(0)

      it "Returns zero when order items array is nothing",
        sinon.test ->
             order =
                 orderItems:undefined
             expect(Functions.getTotalAmount(order)).to.equal(0)
