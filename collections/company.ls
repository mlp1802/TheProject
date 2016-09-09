this.Companies= new Mongo.Collection("companies")
console.log("CREATING COMPANIES ls")
this.Companies.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )
