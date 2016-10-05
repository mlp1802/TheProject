{ClientDao} = require("../../clientDao/clientDao")
getOrders = ->Template.instance().orders.get()
setOrders = (orders)->Template.instance().orders.set(orders)
getShowSearch = ->Template.instance().showSearch.get()
setShowSearch = (show)->Template.instance().showSearch.set(show)

Template.MainOrderList.created =  ->
        this.subscribe("orders")
        this.orders = new ReactiveVar(ClientDao.getOrders())
        this.showSearch = new ReactiveVar(true)
        setShow = Template.instance().showSearch
        PubSub.subscribe("orderUpdated",(msg,obj)->setShow.set(true))
        
Template.MainOrderList.helpers 
    "showSearch":->getShowSearch()
    "getSearchClass": -> if getShowSearch() then "" else "hidden"
            
            
        
    "getOrders":->
        orders = getOrders()
        console.log(orders)
        orders

Template.MainOrderList.events
    
    "click [OrderList-orderRow]":(event)->setShowSearch(false)
    "click [OrderList-closeOrder]":(event)->setShowSearch(true)
    "submit [MainOrderList-searchForm]":(event)->
            event.preventDefault()
            searchString = event.target.MainOrderListSearchString.value
            console.log(searchString)
            orders = ClientDao.getOrdersByCustomerName(searchString)
            console.log(orders)
            setOrders(orders)
            
            