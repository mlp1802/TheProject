{checkRedirects} = require("./enterRedirects")

Accounts.onLogin ()->
    console.log("ON LOGIN")
    FlowRouter.go("home")

Accounts.onLogout (user)->FlowRouter.go("home")


exposed = FlowRouter.group()
          

exposed.route '/verify-email/:token', 
    name:"activate"
    action: (params, queryParams)-> 
        args = {"token":params.token}
        BlazeLayout.render "Activate", args 
        #Accounts.verifyEmail params.token,(error) ->
        #    if !error 
        #        toastr.success("Account activated","Account")
        #    else
        #        toastr.error("Account could not be activated: "+error.reason,"Account")
        #    FlowRouter.go("login")    


exposed.route  "/register",
    name:"register"
    action:->BlazeLayout.render "Register"

exposed.route  "/login",
    name:"login"
    action:->BlazeLayout.render "Login"




        
   
users = FlowRouter.group(
    triggersEnter:[
                    checkRedirects
                  ]
    )

users.route  "/",
              name:"home"
              action:->BlazeLayout.render "Home"

users.route  "/notverified",
              name:"notverified"
              action:->BlazeLayout.render "NotVerified"


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


users.route "/resetPassword",
  name:"resetPassword"
  action:->BlazeLayout.render "ResetPassword"

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

users.route "/admin/users",
  name:"admin"
  action:->BlazeLayout.render "Admin",
                main:"Users"













#
