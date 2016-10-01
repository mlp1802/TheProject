{getAddressFormFields} = require("../misc/AddressFormFieldsFunctions")

Template.Customer.created = ->
    this.showDetails = new ReactiveVar(true)
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
    "click [closeCustomerDetails]":->setShowDetails(false)
    "click [Customer-editCustomer]":->
        setShowDetails(false)
        setShowEdit(true)

    "submit form[EditCustomer-form]":(event)->
        event.preventDefault()
        customer = 
            _id:this.customer._id
            name:event.target.name.value    
            address:getAddressFormFields(event.target)

        Meteor.call("updateCustomer",customer)
        toastr.success("Customer updated","Customer")
        setShowDetails(true)
        setShowEdit(false)
    "click [closeEditCustomer]":->
      console.log("CLOSE EDIT")
      setShowDetails(true)
      setShowEdit(false)


























#
