
getCustomersByName=->
    Template.instance().customers.set(Actions.getCustomersByName())

getCustomersByDate=->
    Template.instance().customers.set(Actions.getCustomersByDate())

getSelectedCustomerId =->
      Template.instance().selectedCustomer.get()
        
setSelectedCustomerId =(id) ->
    Template.instance().selectedCustomer.set(id)     
Template.CustomerList.created = ->
    this.selectedCustomer = new ReactiveVar()
    this.customers = new ReactiveVar()
    _cust = this.customers
    Meteor.call "getCustomersByName",(error,customers) ->
          console.log("CUSTOMERS")
          console.log(customers)
          _cust.set(customers)


Template.CustomerList.helpers
  companies:->Template.instance().customers.get()
  isSelected:(id)->getSelectedCustomerId()==id
  isCustomerSelected:()->getSelectedCustomerId()!=undefined
  getSelectedCustomer:->Company.getCustomer(getSelectedCustomerId())

Template.CustomerList.events
  "click .by_date":(event)->getCustomersByDate()
  "click .by_name":(event)->getCustomersByName()
  "click [CustomerList-closeCustomer]":(event)->
        setSelectedCustomerId(undefined)
        
  "click [CustomerList-customerRow]":(event)->
            id = event.currentTarget.attributes["CustomerList-customerRow"].value
            setSelectedCustomerId(id)


