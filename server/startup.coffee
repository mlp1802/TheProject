
startupActions = []

start = -> startupActions.forEach (action)->action()
addStartAction = (action)->startupActions.push(action)
module.exports = 
	start:start
	addStartAction:addStartAction



