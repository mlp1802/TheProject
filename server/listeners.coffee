orderCreatedListeners = []

addOrderCreatedListener = (listener)->
		orderCreatedListeners.push(listener)
fireOrderCreated = (order)->
	orderCreatedListeners.forEach((listener)->listener(order))


module.exports = 
	addOrderCreatedListener:addOrderCreatedListener
	fireOrderCreated:fireOrderCreated

