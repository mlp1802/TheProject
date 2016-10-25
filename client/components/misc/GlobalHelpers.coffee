
Handlebars.registerHelper "eq",(a,b)->a is b
Handlebars.registerHelper "not",(v)->!v
Handlebars.registerHelper "concat",(x,y)->x+y
Handlebars.registerHelper "theUser",->ServerSession.get("currentUser")
