
getCustomersByName=->
    Template.instance().customers.set(Actions.getCustomersByName())

getCustomersByDate=->
    Template.instance().customers.set(Actions.getCustomersByDate())

getSelectedCustomer =->
      Template.instance().selectedCustomer.get()

setSelectedCustomer = (instance,customer) ->
   	instance.selectedCustomer.set(customer)


Template.CustomerList.created = ->
    this.selectedCustomer = new ReactiveVar()
    this.customers = new ReactiveVar()
    _cust = this.customers
    Meteor.call 'getCustomersByName',(error,result)->
    	_cust.set(result)



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
  "click [CustomerList-closeCustomer]":(event)->setSelectedCustomer(Template.instance(),undefined)

  "click [CustomerList-customerRow]":(event)->
            id = event.currentTarget.attributes["CustomerList-customerRow"].value
            console.log "TEMPLATE INSTANCE lol = "+Template.instance()
            instance = Template.instance()
            Meteor.call "getCustomerById",id,(error,customer)->
                console.log "selected customer "+customer
                setSelectedCustomer instance,customer




