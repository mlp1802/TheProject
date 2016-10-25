
#
Template.Header.events(
    'click [logout]': (event)->
        event.preventDefault()
        Meteor.logout()
        FlowRouter.go("/login")
);
Template.Header.created = ->
    this.currentUser = new ReactiveVar("currentUser")
    self = this
    Meteor.call "getCurrentUser",(success,user)->
        console.log("CURRENT USER HEADER")
        console.log(user)
        self.currentUser.set(user)
        
      

Template.Header.helpers 
    "currentUser":->ServerSession.get("currentUser")#Template.instance().currentUser.get()