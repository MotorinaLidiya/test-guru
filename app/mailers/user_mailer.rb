class UserMailer < ApplicationMailer
  def feedback_email(feedback, test)
    @feedback = feedback
    @test = test

    mail(to: @feedback.author_email, subject: t('user_mailer.feedback_email.subject'))
  end
end
