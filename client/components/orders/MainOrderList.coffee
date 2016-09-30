{ClientDao} = require("../../clientDao/clientDao")
getOrders = ()->Template.instance().orders.get()
setOrders = (orders)->Template.instance().orders.set(orders)
        
Template.MainOrderList.created =  ->
        this.subscribe("orders")
        this.orders = new ReactiveVar(ClientDao.getOrders())
Template.MainOrderList.helpers 
    "getOrders":->
        orders = getOrders()
        console.log(orders)
        orders

Template.MainOrderList.events
    "submit [MainOrderList-searchForm]":(event)->
            event.preventDefault()
            searchString = event.target.MainOrderListSearchString.value
            console.log(searchString)
            orders = ClientDao.getOrdersByCustomerName(searchString)
            console.log(orders)
            setOrders(orders)
            
            