Template.Users.created =-> 
        self = this
        this.userList = new ReactiveVar()
        Meteor.call("getCurrentUserList",(error,users)->
            console.log("RECEIVED USERS "+users)
            self.userList.set(users))
        
Template.Users.helpers 
    "Users":->
        users = Template.instance().userList.get()
        console.log("USERS ")
        console.log(users)
        users
     
        
        