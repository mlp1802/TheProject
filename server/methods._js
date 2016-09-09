
function createCompany(name,address) {
  Companies.insert(
  {
      name:name,
      address:address,
      created_at:new Date()
  })
}
function updateCustomer(id,name,address) {
  console.log("UPDATING CUSTOMER :"+id+" name"+name)
  Companies.update(
   { _id: id },
   { $set:
      {
        name: name,
        address: address
      }
   }
 )
}

function getAllCompanies() {
  return Mongo.Company.find({})
}

Meteor.methods({
    'createCompany':function(name,address) {
      console.log("create company "+name+" "+address)
      Dao.createCompany(name,address)
    },
    'updateCustomer':function(id,name,address) {
      Dao.updateCustomer(id,name,address)
    }
});
