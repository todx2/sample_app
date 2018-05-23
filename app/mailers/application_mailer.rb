class ApplicationMailer < ActionMailer::Base
   #may 22 2018
  default from: "noreply@example.com"
  #default from: 'from@example.com'
  layout 'mailer'
end
