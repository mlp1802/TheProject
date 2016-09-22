
getAddressFormFields = (target)->
        address = 
            address1:target.address1.value    
            address2:target.address2.value
            address3:target.address3.value    
            country:target.country.value
            city:target.city.value
            zip:target.zip.value
            notes:target.notes.value
        address
        
module.exports = {
        getAddressFormFields
        }
        