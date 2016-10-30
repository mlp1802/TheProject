{resetDatabase} = require 'meteor/xolvio:cleaner'
this.ForTest = 
    cleardb:->resetDatabase()
    getPasswords:->Passwords.find().fetch()
    createUser:->
        Users.newUser("mlp2305@gmail.com","skod","someClientId","Mikkel","Petersen")
    resetEmail:(email,password)->
        Users.resetEmail(email,password)

    createClient:(email)->
        Users.getUserByEmail()

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
            clients:Users.getAllClients().fetch()
            users:Users.getAllUsers().fetch()
            resets:Users.getResets().fetch()
            result:result
        }