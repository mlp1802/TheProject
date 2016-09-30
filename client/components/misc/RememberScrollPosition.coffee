getElement = ()->Template.instance().scrollElement.get()
setElement = (e)->Template.instance().scrollElement.set(e)
getId = ->Template.instance().data.scrollId
getYPos = ()->Session.get(getId+"yPos")
setYPos = (yPos)->Session.set(getId+"yPos",yPos)
        
updateScroll = ->
    pos = document.body.scrollTop
    if pos>0 
        setYPos(pos)
    
    
Template.RememberScrollPosition.rendered = ->
        yPos = getYPos()
        $(window).scroll ((event)-> updateScroll())
        if yPos>0 
            Meteor.setTimeout((->$(window).scrollTop(yPos)),500)

Template.RememberScrollPosition.created = ->
        this.scrollElement = new ReactiveVar(undefined)
        this.yPos = new ReactiveVar(undefined)
        
Template.RememberScrollPosition.events
        "click [scroll-element]":(event)->
            id = event.currentTarget.attributes["scroll-element"].value
            #pos = $(event.currentTarget).position()
            pos = document.body.scrollTop
            setYPos(pos)
            setElement(id)
            console.log(id)
            console.log(pos)
            
Template.RememberScrollPosition.helpers
        "hidden":->Template.instance().hidden.get()
        "elements":->[0..100].map((x)->"skodkaj"+x)
        

