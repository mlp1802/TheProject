
loggedIn = ->
        !!Meteor.userId()

Accounts.onLogin (user)->
    console.log("ON LOGIN 1")
    if !Meteor.user().profile.activated 
            FlowRouter.go("/login")
        else
            FlowRouter.go("home")
            
        
    
    

Accounts.onLogout (user)->FlowRouter.go("home")


exposed = FlowRouter.group()
          

exposed.route '/activate/:userId', 
    name:"activate"
    action: (params, queryParams)-> 
        Meteor.call("activateUser",params.userId)

    

exposed.route  "/register",
    name:"register"
    action:->BlazeLayout.render "Register"

exposed.route  "/login",
    name:"login"
    action:->BlazeLayout.render "Login"


users = FlowRouter.group(
    triggersEnter:[->
                    if loggedIn() is false
                      FlowRouter.go("/login")]
    )

users.route  "/",
              name:"home"
              action:->BlazeLayout.render "Home"

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

users.route "/profile",
    name:"profile"
    action:->BlazeLayout.render "Profile"
                


users.route "/customers/new",
  name:"customers-new"
  action:->BlazeLayout.render "Customers",
              main:"NewCustomer"

users.route "/orders",
  name:"orders"
  action:->BlazeLayout.render "Orders",
              main:"MainOrderList"

users.route "/admin",
  name:"admin"
  action:->BlazeLayout.render "Admin"

users.route "/admin/newuser",
  name:"admin"
  action:->BlazeLayout.render "Admin",
                main:"NewUser"














#
