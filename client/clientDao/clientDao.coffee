
getCustomersByName =(callback)->
	Meteor.call 'getCustomersByName',callback
getCustomerById = (id,callback)->
	Meteor.call "getCustomerById",id,callback

getOrder = (id,callback)->
		Meteor.call "getOrder",id,callback
getOrdersByCustomerId =(id,callback) ->
		Meteor.call "getOrdersByCustomerId",id,callback


module.exports =
	getCustomersByName:getCustomersByName
	getCustomerById:getCustomerById
	getOrdersByCustomerId:getOrdersByCustomerId
	getOrder:getOrder

