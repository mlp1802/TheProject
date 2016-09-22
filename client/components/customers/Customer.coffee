{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.Customer.created = ->
    this.showDetails = new ReactiveVar(false)
    this.showEdit = new ReactiveVar(false)
    this.showOrders = new ReactiveVar(false)

instance = ->Template.instance()
setShowDetails = (v)->instance().showDetails.set(v)
setShowEdit = (v)->instance().showEdit.set(v)
setShowOrders =(v)->instance().showOrders.set(v)
getShowOrders = ->instance().showOrders.get()
getShowEdit = ->instance().showEdit.get()
getShowDetails = ->instance().showDetails.get()
toggleShowDetails = ->setShowDetails(not getShowDetails())

Template.Customer.helpers
  showDetails:->getShowDetails()
  shouldShowHeader:->not (getShowEdit() || getShowDetails()||getShowOrders())
  showEdit:->getShowEdit()
  showOrders:->getShowOrders()


Template.Customer.events
    "click .customerClick":->toggleShowDetails()
    "click [closeCustomerDetails]":->setShowDetails(false)
    "click [editCustomer]":->
        setShowDetails(false)
        setShowEdit(true)
    "click [orders]":->
       setShowOrders(true)
       setShowDetails(false)
    "submit form[EditCustomer-Form]":(event)->
        event.preventDefault()
        
        customer = ne
            _id:this.customer._id
            name:event.target.name.value    
            address:getAddressFormFields(event.target)

        Meteor.call("updateCustomer",customer)
        setShowDetails(false)
        setShowEdit(false)
    "click [closeEditCustomer]":->
      setShowDetails(false)
      setShowEdit(false)
    "click [closeOrderAdmin],[NewOrder-closeNewOrder]":->
      setShowDetails(false)
      setShowEdit(false)
      setShowOrders(false)

























#
