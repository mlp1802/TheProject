console.log("PUBLISHING")
Meteor.publish("companies", function(argument){
    return Companies.find({})
});
