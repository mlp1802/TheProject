{Meteor} = require("meteor/meteor")
{Mongo} = require("meteor/mongo")
{resetDatabase} = require 'meteor/xolvio:cleaner'
UserCollection = new Mongo.Collection("SystemUsers")
Clients = new Mongo.Collection("clients")
Passwords = new  Mongo.Collection("passwords")
newUser = (email,password,clientId,firstName,lastName)->
    user = 
        email:email
        firstName:firstName
        lastName:lastName
        clientId:clientId
    id = UserCollection.insert(user)
    Passwords.insert({userId:id,password:password})

getAllUsers = ->
    UserCollection.find().fetch()

getAllClients = ->
    Clients.find().fetch()
getUser = (email) ->
    UserCollection.findOne({email:email})


getPassword = (userId)->
    Passwords.findOne {userId:userId}

newClient = (email,password,companyName,firstName,lastName)->
    client = 
        email:email
        companyName:companyName
        firstName:firstName
        lastName:lastName
    clientId = Clients.insert(client)
    Users.newUser(email,password,clientId,firstName,lastName)     

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
    getCurrentUser:->ServerSession.get("currentUser")
    getClientId:->ServerSession.get("currentUser").clientId
        


    

this.ForTest = 
    cleardb:->resetDatabase()
    getPasswords:->Passwords.find().fetch()
    createUser:->
        Users.newUser("mlp2305@gmail.com","skod","someClientId","Mikkel","Petersen")
    createClient:->
        Users.newClient("mlp2305@gmail.com","skod","Microsoft","Mikkel","Petersen")

















#