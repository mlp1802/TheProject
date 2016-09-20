{ClientDao} = require("../../clientDao/clientDao")
getCustomersByName=->
    Template.instance().customers.set(ClientDao.getCustomersByName())

getCustomersByDate=->
    Template.instance().customers.set(ClientDao.getCustomersByDate())

Template.CustomerList.created = ->
    this.subscribe("companies")
    this.customers = new ReactiveVar()
    getCustomersByName()

Template.CustomerList.helpers(
  companies:->Template.instance().customers.get()
)
Template.CustomerList.events(
  "click .by_date":(event)->getCustomersByDate()

  "click .by_name":(event)->getCustomersByName()
)
