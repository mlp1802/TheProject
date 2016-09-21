chai = require("chai")
chaiSubset = require('chai-subset');
td = require 'testdouble';
chai.use(chaiSubset)
assert = chai.assert
expect = chai.expect
sinonChai = require("sinon-chai")
sinon = require "sinon"
require("./meteorMock")
{getPct,isNumber,setIdIfEmpty} = require '../server/misc'


test = sinon.test

describe  "Misc.isNumber",
      ->
        it "is a number",
          test ->
              expect(isNumber(23)).to.be.true

        it "is not a number",
          test ->
              #expect(isNaN("")).to.be.true
              expect(isNumber("abc")).to.be.false
              expect(isNumber(undefined)).to.be.false
              expect(isNumber("")).to.be.false

describe "Misc.GetPct",
      ->
        it "Returns percentage when correct string",
          test ->
              expect(getPct("10%")).to.equal(10)

        it "Returns 0 when string not parseable",
          test ->
              expect(getPct("23a")).to.equal(0)


describe "Misc.setIdIfEmpty",
      ->
        it "Sets an _id if id not present",
          test ->
              obj = {}
              setIdIfEmpty (obj)
              expect(obj._id).to.be.a.string
        it "Do not set ID if already present",
          test ->
              obj = {_id:"already_an_id"}
              setIdIfEmpty (obj)
              expect(obj._id).to.equal("already_an_id")
