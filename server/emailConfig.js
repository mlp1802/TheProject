

Accounts.emailTemplates.siteName = "The System";
Accounts.emailTemplates.from     = "The System <admin@thesystem.com>";

Accounts.emailTemplates.verifyEmail = {
  subject() {
    return "[The System] Activate your account";
  },
  text( user, url ) {
    let emailAddress   = user.emails[0].address,
        urlWithoutHash = url.replace( '#/', '' ),
        supportEmail   = "support@thesystem.com",
        emailBody      = `To activate your account (${emailAddress}) visit the following link:\n\n${urlWithoutHash}\n\n If you did not request this verification, please ignore this email. If you feel something is wrong, please contact our support team: ${supportEmail}.`;

    return emailBody;
  }
}

  
  
  
  


