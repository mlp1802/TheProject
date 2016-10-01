getTemplateId = ->"RememberSelected_"+Template.instance().data.selectId
getSelected = ->Session.get("selected"+getTemplateId())
setSelected = (id)->Session.set("selected"+getTemplateId(),id)
    
                    

getSelectedClass = ()->Template.instance().data.selectedClass
getPrevSelected = ->Template.instance().prevSelected.get()
setPrevSelected = (id)->Template.instance().prevSelected.set(id)

removeClass = (element)->$(element).removeClass(getSelectedClass())
addClass = (element)->$(element).addClass(getSelectedClass())
getElement = (id)->$("[RememberSelectedId="+id+"]")
removePrevious = ->
    id = getPrevSelected()
    if id!=undefined
        removeClass(getElement(id))
        
Template.RememberSelected.rendered = ->
    element = getElement(getSelected())
    addClass(element)
        
Template.RememberSelected.created = ->
    this.prevSelected = new ReactiveVar()
    
Template.RememberSelected.events
    "click [RememberSelectedId]":(event)->
        removePrevious()
        id = event.currentTarget.attributes["RememberSelectedId"].value
        setSelected(id)
        setPrevSelected(id)
        addClass(event.currentTarget)
