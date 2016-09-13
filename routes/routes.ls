
loggedIn = ->
        !!Meteor.userId()


Accounts.onLogin (user)->FlowRouter.go("customers")
exposed = FlowRouter.group()

users = FlowRouter.group(
    triggersEnter:[->
                    console.log("Triggered "+Meteor.userId())
                    if loggedIn() is false
                      FlowRouter.go("/")]
    )
exposed.route  "/",
              name:"home"
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
