getId = ->Template.instance().data.scrollId
getYPos = ()->Session.get(getId+"yPos")
setYPos = (yPos)->
    Session.set(getId+"yPos",yPos)
        
updateScroll = ->
    pos = document.body.scrollTop
    
Template.RememberScrollPosition.rendered = ->
    $(window).scrollTop(getYPos())
        
Template.RememberScrollPosition.destroyed = ->
        setYPos(document.body.scrollTop)
        
Template.RememberScrollPosition.created = ->
    this.yPos = new ReactiveVar(undefined)



