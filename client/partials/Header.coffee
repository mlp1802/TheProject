
#
Template.Header.events(
    'click [logout]': (event)->
        event.preventDefault()
        Meteor.logout()
        FlowRouter.go("/login")
);