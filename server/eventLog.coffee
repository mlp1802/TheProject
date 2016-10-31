EventLog = new Mongo.Collection("event_log")

insertEvent = (e)->EventLog.insert(e) 
orderCreated = (order)->
		e = 
			type:"orderCreated"
			orderId:order._id
			createdBy:Actions.getCurrentShortUser()
		insertEvent e


getAllEvents = ->
		EventLog.find().fetch()
		EventLog.find {},
	                  sort:
	                    created_at:-1
this.EventLog = 
	orderCreated:orderCreated
	getAllEvents:getAllEvents




	


	