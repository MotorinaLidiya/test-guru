class ApplicationMailer < ActionMailer::Base
  default from: "TestGuru <#{ENV.fetch('SMTP_USERNAME', nil)}>"
  layout 'mailer'
end
