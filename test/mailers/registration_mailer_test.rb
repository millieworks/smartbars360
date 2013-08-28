require "minitest_helper"

describe RegistrationMailer do
  it "welcome" do
    skip
    mail = RegistrationMailer.welcome(user, password)
    mail.subject.must_equal "Welcome"
    mail.to.must_equal ["to@example.org"]
    mail.from.must_equal ["from@example.com"]
    mail.body.encoded.must_match "Hi"
  end
end
