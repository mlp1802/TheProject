createCompany = (name,address)->
  Companies.insert(
      name:name,
      address:address,
      created_at:new Date()
      )

updateCustomer = (id,name,address)->
  Companies.update(
    _id: id
    $set:
        name: name
        address: address
    )

getAllCompanies =->Mongo.Companies.find({})



Dao =
    createCompany:createCompany
    updateCustomer:updateCustomer
    getAllCompanies:getAllCompanies


module.exports =
    Dao:Dao
