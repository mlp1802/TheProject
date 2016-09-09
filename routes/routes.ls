
checkLogin = ->
        Meteor.userId!=null

main = ->
  if checkLogin()
      FlowRouter.go("main")
  else
      BlazeLayout.render("Home")




Accounts.onLogin (user)->FlowRouter.go("main")
Accounts.onLogin (user)->FlowRouter.go("home")
exposed = FlowRouter.group()
users = FlowRouter.group()
exposed.route  "/",
              name:"main"
              action:->main()

users.route "/",
  name:"main"
  action:->BlazeLayout.render "klCustomers",
              nain:"CustomerList"


users.route "/main",
  name:"main"
  action:->BlazeLayout.render "Main"

users.route "/customers",
  name:"customers"
  action:->BlazeLayout.render "Customers",
              main:"CustomerList"

users.route "/customers/new",
  name:"customers-new"
  action:->BlazeLayout.render "Customers",
              main:"NewCustomer"
