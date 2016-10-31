{resetDatabase} = require 'meteor/xolvio:cleaner'
users = require "./users"
actions = require "./actions"

this.ForTest = 
    cleardb:->resetDatabase()
    getPasswords:->Passwords.find().fetch()
    login:(email,password)->users.login(email,password)
    createUser:->
        users.newUser("mlp2305@gmail.com","skod","someClientId","Mikkel","Petersen")
    resetEmail:(email,password)->
        users.resetEmail(email,password)

    
    getAllUsers:->
        users.getAllUsers().fetch()
    
    getAllCustomers: ->
        actions.allCompanies().fetch()
    createClient:(email)->
        users.getUserByEmail()

        #ForTest.cleardb()
        user = 
               email: "mlp2305@gmail.com"
               firstName:"Mikkel"
               lastName:"Petersen"
               
        client = 
               email: "mlp2305@gmail.com"
               companyName:"OB"


        result = Actions.newClient(client,user)       
        {
            clients:users.getAllClients().fetch()
            users:users.getAllusers().fetch()
            resets:users.getResets().fetch()
            result:result
        }