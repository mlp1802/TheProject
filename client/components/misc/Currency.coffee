Template.Currency.helpers(

  "format":(str)->
        formatter = new Intl.NumberFormat('th-TH',
            style:"currency"
            currency:this.currency
            minimumFractionDigits: 2
            currencyDisplay:"symbol"
            )
        #currency.toStr(Number(this.amount))
        formatter.format(this.amount)
  )
