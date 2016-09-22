chai = require("chai")
chaiSubset = require('chai-subset');
chai.use(chaiSubset)
assert = chai.assert
expect = chai.expect
sinonChai = require("sinon-chai")
CollectionMock = require("./meteorMock").CollectionMock
sinon = require "sinon"
Dao = require '../server/dao'
orderFunctions = require("../server/orderFunctions")
chai.use sinonChai
chai.should()
test = sinon.test
newOrder = ->
  customerId:"cust_id"
  customerName:"bob"
  orderItems:[]
  orderExtras:[]

describe "Dao.CreateCompany", ->
      it "Total amount gets called", test ->
        company  = 
                name:"test"
        insert = this.spy(CollectionMock,"insert")
        Dao.createCompany(company)
        insert.should.have.callCount(1)
                


describe "Dao.SaveNewOrder",
    ->
      it "Total amount gets called", test ->
          getTotalAmount = this.spy(orderFunctions,"getTotalAmount")
          Dao.saveNewOrder newOrder()
          getTotalAmount.should.have.callCount(1)

      it "Object status, curreny and date get inserted", sinon.test ->
          insert = this.spy(CollectionMock,"insert")
          Dao.saveNewOrder newOrder()
          new_order  = insert.getCall(0).args[0]
          expect(new_order.created_at).to.not.equal undefined
          expect(new_order.status).to.equal "not_paid"
          expect(new_order.currency).to.equal "THB"

      it 'Insert gets called once',sinon.test ->
        insert = this.spy(CollectionMock,"insert")
        Dao.saveNewOrder(newOrder())
        insert.should.have.callCount(1)

describe "Dao.UpdateOrder",
    ->
      it 'Insert gets called once',sinon.test ->
        update = this.spy(CollectionMock,"update")
        Dao.updateOrder(newOrder())
        update.should.have.callCount(1)
