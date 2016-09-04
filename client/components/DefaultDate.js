Template.DefaultDate.helpers({
  formatDate:function(date) {
      return moment(date).format('MMMM Do YYYY, h:mm:ss a')
  }
})
