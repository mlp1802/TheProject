orderFunctions = require '../server/orderFunctions'
chai = require("chai")
chaiSubset = require('chai-subset');
chai.use(chaiSubset)
assert = chai.assert
expect = chai.expect

sinonChai = require("sinon-chai")
sinon = require "sinon"
test = sinon.test
describe "OrderFunctions.GetTotalAmount",
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
            total = orderFunctions.getTotalAmount(order)
            expect(total).to.equal(45)

      it "Returns zero when empty order items arays",
          test ->
            order =
                orderItems:[]
            expect(orderFunctions.getTotalAmount(order)).to.equal(0)


      it "Returns zero when order items array is nothing",
          test ->
             order =
                 orderItems:undefined
             expect(orderFunctions.getTotalAmount(order)).to.equal(0)


describe "OrderFunctions.getAmountForExtra",
      ->
        it "Adds value",
          test ->
              expect(orderFunctions.getAmountForExtra(100,"10")).to.equal(110)

        it "Subtracts a value",
          test ->
              expect(orderFunctions.getAmountForExtra(100,"-10")).to.equal(90)

        it "Adds a pct",
          test ->
              expect(orderFunctions.getAmountForExtra(45,"10%")).to.equal(45+(45*0.1))

        it "Subtracts a pct",
          test ->
              expect(orderFunctions.getAmountForExtra(45,"-10%")).to.equal(45-(45*0.1))

        it "Returns amount when value is not parseable",
          test ->
              expect(orderFunctions.getAmountForExtra(45,"adf2323")).to.equal(45)
