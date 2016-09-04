
function createCompany(name,address) {
  Companies.insert(
  {
      name:name,
      address:address,
      created_at:new Date()
  })
}

function getAllCompanies() {
  return Mongo.Company.find({})
}

Meteor.methods({
    'createCompany':function(name,address) {
      console.log("create company "+name+" "+address)
      createCompany(name,address)
    }
});
