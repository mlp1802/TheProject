getId = ->"RememberScrollPosition_"+Template.instance().data.scrollId
getYPos = ()->Session.get(getId())
setYPos = (yPos)->
    Session.set(getId(),yPos)
        
updateScroll = ->
    pos = document.body.scrollTop
    
Template.RememberScrollPosition.rendered = ->
    $(window).scrollTop(getYPos())
        
Template.RememberScrollPosition.destroyed = ->
        setYPos(document.body.scrollTop)
        
Template.RememberScrollPosition.created = ->
    this.yPos = new ReactiveVar(undefined)



