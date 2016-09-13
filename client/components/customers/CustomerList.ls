getCustomersByName=->
    Companies.find({},
              sort:
                  name:1
              )

getCustomersByDate=->
    Companies.find({},
              sort:
                  created_at:-1
              )

Template.CustomerList.created = ->
    this.subscribe("companies")
    this.sortOrder = new ReactiveVar("by_name")
    console.log("CSCREATED LOL")

Template.CustomerList.helpers(
  companies:->
      console.log("COMP LOL")
      sortOrder = Template.instance().sortOrder.get()
      if sortOrder == "by_name"
          getCustomersByName()
      else
          getCustomersByDate()
)
Template.CustomerList.events(
  "click .by_date":(event)->
      Template.instance().sortOrder.set("by_date")
  "click .by_name":(event)->
      Template.instance().sortOrder.set("by_name")
)
