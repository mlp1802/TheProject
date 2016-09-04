//logon/off redirects
Accounts.onLogin(function(user) {
  FlowRouter.go("main")
})

Accounts.onLogout(function() {
  FlowRouter.go("home")
})

//helper functions
function checkLogin() {
  if(!Meteor.userId()) {
      FlowRouter.go("home")
  }
}
//Groups
let exposed = FlowRouter.group()
let loggedIn = FlowRouter.group({
  triggersEnter:[checkLogin]
})




exposed.route("/",{
  name:"home",
  action() {
    if(Meteor.userId()) {
      FlowRouter.go("main")
    }
    BlazeLayout.render("Home");
  }
})
loggedIn.route("/main",{
  name:"main",
  action() {
    BlazeLayout.render("Main");
  }
})

loggedIn.route("/customers",{
  name:"customers",
  action() {
    BlazeLayout.render("Customers",
    {main:"CustomerList"});
  }
})
loggedIn.route("/customers/new",{
  name:"customers-new",
  action() {
    BlazeLayout.render("Customers",{main:"NewCustomer"});
  }
})

loggedIn.route("/tasks",{
  name:"tasks",
  action() {
      BlazeLayout.render("Tasks");
  }

  })
loggedIn.route("/orders",{
  name:"orders",
  action() {
    BlazeLayout.render("Orders");
  }
})
loggedIn.route("/admin",{
  name:"admin",
  action() {
    BlazeLayout.render("Admin");
  }
})
