class WelcomeNotificationMailer < ApplicationMailer
  defualt from: 'no-reply@high.max.school.com'

  def welcome_email(user)
    @user = user
    @url = 'https://high.max.school.com/login'

    mail(
      to: @user.email,
      subject: 'Welcome to High School!'
    )
  end
end
