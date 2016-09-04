Companies = new Mongo.Collection("companies");
console.log("CREATING COMPANIES")
Companies.allow({
  insert:function(userId,doc) {
      return !!userId
  },
  update:function(userId,doc) {
      return !!userId
  },
})
