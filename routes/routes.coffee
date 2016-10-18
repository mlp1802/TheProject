
loggedIn = ->
        !!Meteor.userId()

Accounts.onLogin (user)->
    FlowRouter.go("home")

Accounts.onLogout (user)->FlowRouter.go("home")
exposed = FlowRouter.group()
          

users = FlowRouter.group(
    triggersEnter:[->
                    if loggedIn() is false
                      FlowRouter.go("/login")]
    )

users.route  "/",
              name:"home"
              action:->BlazeLayout.render "Home"

exposed.route  "/register",
    name:"register"
    action:->BlazeLayout.render "Register"

exposed.route  "/login",
    name:"login"
    action:->BlazeLayout.render "Login"

users.route "/ScrollToTest",
    name:"ScrollToTest"
    action:->BlazeLayout.render "ScrollToTest",
             main:"CustomerList"
         
users.route "/HideSomething",
    name:"HideSomething"
    action:->BlazeLayout.render "HideSomething",
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
