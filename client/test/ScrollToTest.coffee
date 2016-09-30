#
Template.ScrollToTest.rendered = ->
    el = this.$("#lol3")
    $(window).scrollTop( $("#lol3").offset().top-400);
    #window.scrollTo(300,{})
    console.log("KLOL "+window)
    console.log("KLOL2 "+el)
    