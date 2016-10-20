Meteor.startup(->)
Accounts.onLogin (user)->
        if !Meteor.user().profile.activated 
            Meteor.logout()
        
        


        

    
