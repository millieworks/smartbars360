class RegistrationMailer < ActionMailer::Base
  default from: "noreply@onserver360.se"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def welcome(user, password)
    @greeting = "Hi"
    @email = user.email
    @password = password

    mail to: user.email
  end
end
