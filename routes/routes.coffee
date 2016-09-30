
loggedIn = ->
        !!Meteor.userId()


Accounts.onLogin (user)->FlowRouter.go("customers")
Accounts.onLogout (user)->FlowRouter.go("home")
exposed = FlowRouter.group()

users = FlowRouter.group(
    triggersEnter:[->
                    if loggedIn() is false
                      FlowRouter.go("/")]
    )
exposed.route  "/",
              name:"home"
              action:->BlazeLayout.render "Home"

users.route "/ScrollToTest",
    name:"ScrollToTest"
    action:->BlazeLayout.render "ScrollToTest",
             main:"CustomerList"
         
users.route "/customers",
  name:"customers"
  action:->BlazeLayout.render "Customers",
              main:"CustomerList"


users.route "/customers/new",
  name:"customers-new"
  action:->BlazeLayout.render "Customers",
              main:"NewCustomer"

users.route "/orders",
  name:"orders"
  action:->BlazeLayout.render "Orders",
              main:"MainOrderList"















#
