{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
{resetDatabase} = require 'meteor/xolvio:cleaner'
UserCollection = new Mongo.Collection("SystemUsers")
Clients = new Mongo.Collection("clients")
Passwords = new  Mongo.Collection("passwords")
ResetPassword = new  Mongo.Collection("resetpassword")



getAllUsers = ->
    UserCollection.find()

getAllClients = ->
    Clients.find()

getUser = (email) ->
    UserCollection.findOne({email:email})


getPassword = (userId)->
    Passwords.findOne {userId:userId}

getResets = ->
        ResetPassword.find()

    #Passwords.insert({userId:id,password:password})


setPassword = (userId,password)->
    p = getPassword userId
    if p 
        Passwords.update({userId:userId},{userId:userId,password:password})
    else
        Passwords.insert({userId:userId,password:password})            

resetPassword = (token,password)->
    reset = ResetPassword.findOne {_id:token}
    if reset
        userId = reset.userId
        setPassword userId,password
        ResetPassword.remove({userId:userId})
        true
    else
        false
    

newUser = (user)->
    password = user.password
    delete user.password
    id = UserCollection.insert(user)
    resetId = ResetPassword.insert({userId:id})
    {
        userId:id
        resetId:resetId
    }
    

newClient = (client,user)->
    user.clientId = Clients.insert(client)
    Users.newUser(user)     

login = (email,password)->
    user = getUser(email)
    if(!user) 
        false
    else
        passwordCheck = getPassword user._id
        if password==passwordCheck.password 
            ServerSession.set("currentUser",getUser(email))
            true
        else
            false
    


#login(email,password) = ->


this.Users = 
    newUser:newUser
    newClient:newClient
    getAllUsers:getAllUsers
    getAllClients:getAllClients
    getUser:getUser
    login:login
    getResets:getResets
    resetPassword:resetPassword
    setPassword:setPassword
    getCurrentUser:->ServerSession.get("currentUser")
    getClientId:->ServerSession.get("currentUser").clientId
        


    

this.ForTest = 
    cleardb:->resetDatabase()
    getPasswords:->Passwords.find().fetch()
    createUser:->
        Users.newUser("mlp2305@gmail.com","skod","someClientId","Mikkel","Petersen")
    createClient:->
        ForTest.cleardb()
        user = 
               email: "mlp2305@gmail.com"
               firstName:"Mikkel"
               lastName:"Petersen"
               
        client = 
               email: "mlp2305@gmail.com"
               companyName:"OB"


        Actions.newClient(client,user)       
        {
            clients:Users.getAllClients().fetch()
            users:Users.getAllUsers().fetch()
            resets:Users.getResets().fetch()
        }















#