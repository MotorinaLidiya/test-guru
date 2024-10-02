class ApplicationMailer < ActionMailer::Base
  default from: "TestGuru <#{ENV['SMTP_USERNAME']}>"
  layout 'mailer'
end
