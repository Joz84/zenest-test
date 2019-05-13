class EmployeeMailerPreview < ActionMailer::Preview
  def booking_confirmation
    attendee = Attendee.first
    EmployeeMailer.booking_confirmation(attendee).deliver_now
  end
end
