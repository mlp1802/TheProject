
getCustomersByName=->
    Template.instance().customers.set(Actions.getCustomersByName())

getCustomersByDate=->
    Template.instance().customers.set(Actions.getCustomersByDate())

getSelectedCustomer =->
      Template.instance().selectedCustomer.get()
        
setSelectedCustomer =(customer) ->
    Template.instance().selectedCustomer.set(id)     


Template.CustomerList.created = ->
    this.selectedCustomer = new ReactiveVar()
    this.customers = new ReactiveVar()
    _cust = this.customers


Template.CustomerList.helpers
  companies:->Template.instance().customers.get()
  isSelected:(id)->
    c = getSelectedCustomer()
    if c!=undefined 
      c._id==id
    else
      false
  isCustomerSelected:()-> getSelectedCustomer()!=undefined
  getSelectedCustomer:->getSelectedCustomer()

Template.CustomerList.events
  "click .by_date":(event)->getCustomersByDate()
  "click .by_name":(event)->getCustomersByName()
  "click [CustomerList-closeCustomer]":(event)->
        setSelectedCustomerId(undefined)
        
  "click [CustomerList-customerRow]":(event)->
            id = event.currentTarget.attributes["CustomerList-customerRow"].value
            Meteor.call "getCustomerById",id,(error,customer)->
                setSelectedCustomer customer
            



