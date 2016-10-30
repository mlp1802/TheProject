Template.Users.created =-> 
        self = this
        this.userList = new ReactiveVar()
        Meteor.call("getCurrentUserList",(error,users)->
            self.userList.set(users))
        
Template.Users.helpers 
    "lastLogin":(date)->
        if ! date
            "Never"
        else
            moment(date).format('MM-DD-YY')


    "Users":->
        users = Template.instance().userList.get()
        console.log("USERS ")
        console.log(users)
        users
     
        
        