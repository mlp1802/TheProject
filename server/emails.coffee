sendResetEmail = (email,resetId)->
    email = "mlp2305@gmail.com"
    link = "http://localhost:3000/activate/"+resetId
    body = "Activate your account by clicking this link <a href='#{link}'>#{link}</a>"
    email =
            from:"admin@thesystem.com"
            to:email
            subject:"Activate your account"
            html:body
    Email.send email


this.Emails =
	sendResetEmail:sendResetEmail