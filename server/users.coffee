{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")

UserCollection = new Mongo.Collection("SystemUsers")
Clients = new Mongo.Collection("clients")
Passwords = new  Mongo.Collection("passwords")
ResetPassword = new  Mongo.Collection("resetpassword")



getAllUsers = ->
    UserCollection.find()

getAllClients = ->
    Clients.find()

getClientByEmail = (email) ->
    Clients.findOne({email:email})

getUsersByClientId = (clientId)->
    UserCollection.find ({clientId:clientId})

getUserByEmail = (email) ->
    UserCollection.findOne {email:email}

updateUser = (user)->
    console.log("UPDATING USER ")
    console.log(user)
    UserCollection.update {_id:user._id},user

toShortUser = (user)->
        u = 
            "_id":user._id
            "name":user.firstName+" "+user.lastName
            "email":user.email

resetEmail =(email,password)->
    user = getUserByEmail email
    token = (ResetPassword.findOne {userId:user._id})._id
    resetPassword token,password


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
    

newClient = (client,user)->
    c = getClientByEmail(client.email)
    u = getUserByEmail(user.email)
    if c!=undefined || u!=undefined
           {
            error:true
            reason:"Email is already in the system"
           } 
       else
            user.clientId = Clients.insert(client)
            Users.newUser(user.clientId,user)         
    

newReset = (userId)->
    ResetPassword.remove({userId:userId})
    ResetPassword.insert({userId:userId})    

newUser = (clientId,user)->
    u = getUserByEmail(user.email)
    if u
        error:true
        reason:"Email is already in the system"
    else
        user.clientId = clientId
        id = UserCollection.insert(user)
        {
            userId:id
            resetId:newReset id
        }
    



login = (email,password)->
    user = getUserByEmail(email)
    if(!user) 
        false
    else
        passwordCheck = getPassword user._id
        if(passwordCheck)
            if password==passwordCheck.password 
                ServerSession.set("currentUser",getUserByEmail(email))
                user.lastLogin = new Date()
                UserCollection.update({_id:user._id},user)
                true
            else
                false
        else
            false


#login(email,password) = ->


module.exports = 
    newUser:newUser
    newClient:newClient
    getAllUsers:getAllUsers
    getAllClients:getAllClients
    getUserByEmail:getUserByEmail
    login:login
    getResets:getResets
    resetPassword:resetPassword
    setPassword:setPassword
    getCurrentUser:->ServerSession.get("currentUser")
    getClientId:->ServerSession.get("currentUser").clientId
    getUsersByClientId:getUsersByClientId,
    resetEmail:resetEmail
    updateUser:updateUser
    toShortUser:toShortUser
        


    

















#