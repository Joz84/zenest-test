require 'test_helper'

class StripeMailerTest < ActionMailer::TestCase
  test "errors" do
    mail = StripeMailer.errors
    assert_equal "Errors", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
