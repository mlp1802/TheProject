{ClientDao} = require("../../clientDao/clientDao")
getCustomersByName=->
    Template.instance().customers.set(ClientDao.getCustomersByName())

getCustomersByDate=->
    Template.instance().customers.set(ClientDao.getCustomersByDate())

getSelectedCustomerId =->
      Template.instance().selectedCustomer.get()
        
setSelectedCustomerId =(id) ->
    Template.instance().selectedCustomer.set(id)     
Template.CustomerList.created = ->
    this.subscribe("companies")
    this.selectedCustomer = new ReactiveVar()
    this.customers = new ReactiveVar()
    getCustomersByName()


Template.CustomerList.helpers
  companies:->Template.instance().customers.get()
  isSelected:(id)->getSelectedCustomerId()==id
  isCustomerSelected:()->getSelectedCustomerId()!=undefined
  getSelectedCustomer:->ClientDao.getCustomer(getSelectedCustomerId())

Template.CustomerList.events
  "click .by_date":(event)->getCustomersByDate()
  "click .by_name":(event)->getCustomersByName()
  "click [CustomerList-closeCustomer]":(event)->
        setSelectedCustomerId(undefined)
        
  "click [CustomerList-customerRow]":(event)->
            id = event.currentTarget.attributes["CustomerList-customerRow"].value
            setSelectedCustomerId(id)


