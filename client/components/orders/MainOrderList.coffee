clientDao = require("../../queries")
self = null
search = null
getOrders = ->self.orders.get()
setOrders = (orders)->self.orders.set(orders)
getShowSearch = ->self.showSearch.get()
setShowSearch = (show)->self.showSearch.set(show)


Template.MainOrderList.created =  ->
        self = this
        search =->
          clientDao.getOrders (error,result)->
          	setOrders(result)
        self.orders = new ReactiveVar()
        self.showSearch = new ReactiveVar(true)
        PubSub.subscribe "orderUpdated",(msg,obj)->
           self.showSearch.set(true)
           search()
        search()


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
            search = ->
                clientDao.searchOrders searchString,(error,orders)->
                    console.log "ORDER LOL"
                    console.log orders
                    setOrders(orders)
            search()
