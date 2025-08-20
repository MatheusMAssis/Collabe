require "test_helper"

class EventMailerTest < ActionMailer::TestCase
  test "registration_notification" do
    mail = EventMailer.registration_notification
    assert_equal "Registration notification", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
