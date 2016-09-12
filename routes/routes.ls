
checkLogin = ->
        Meteor.userId!=null


Accounts.onLogin (user)->FlowRouter.go("main")
Accounts.onLogin (user)->FlowRouter.go("home")
exposed = FlowRouter.group()
users = FlowRouter.group()
exposed.route  "/",
              name:"main"
              action:->BlazeLayout.render "Home"

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
              main:"OrderList"















#
