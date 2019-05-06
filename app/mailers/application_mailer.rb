class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@heroku.com'
  layout 'mailer'
end
