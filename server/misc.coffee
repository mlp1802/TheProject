{Random} = require("meteor/random")

setIdIfEmpty = (object)->
  if object._id is undefined
      console.log("setting id")
      object._id = Random.id()
      console.log("id is now "+object._id)

isNumber =(n)->
    if n is undefined | n==""
        false
    else
        not isNaN(n)

getPct=(value)->
  value=value.replace("%","")
  if isNumber(value)
      Number(value)
  else
      0


module.exports = {
    setIdIfEmpty,
    isNumber,
    getPct
    }
