
#
Template.Header.events(
    'click [logout]': (event)->
        event.preventDefault()

        Meteor.call("doLogout")
        FlowRouter.go("/login")

);
Template.Header.created = ->
    this.currentUser = new ReactiveVar("currentUser")
    self = this
    Meteor.call "getCurrentUser",(success,user)->
        console.log(user)
        self.currentUser.set(user)

Template.Header.helpers
    "currentUser":->ServerSession.get("currentUser")#Template.instance().currentUser.get()