#
Template.HideSomething.created = ->
        this.hidden = new ReactiveVar(false)

Template.HideSomething.helpers
        "hidden":->Template.instance().hidden.get()

Template.HideSomething.events
    "click [hideButton]":->Template.instance().hidden.set(!Template.instance().hidden.get())
    "click [scroll-element]":->Template.instance().hidden.set(!Template.instance().hidden.get())

        