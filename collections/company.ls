Companies= new Mongo.Collection("companies")
Companies.allow(
    insert:(userId)->!userId
    update:(userId)->!userId
    )

module.exports =
    "Companies":Companies
