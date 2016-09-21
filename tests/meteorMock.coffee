td = require 'testdouble';
Meteor = td.object(["methods", "call"])
Random = {
    id:->
        "random_id"
}
td.replace("meteor/random", { Random })

CollectionMock =
    insert:(a)->
    update:(a)->

class Collection
    (@name)->
    allow:(a)->
    insert:(a)->CollectionMock.insert(a)
    update:(a)->CollectionMock.update(a)


Mongo =
    Collection:Collection


td.replace("meteor/meteor", { Meteor })
td.replace("meteor/mongo", { Mongo})
module.exports =
  "Mongo":Mongo
  "Meteor":Meteor
  "CollectionMock":CollectionMock
