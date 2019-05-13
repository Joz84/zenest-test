class EmployeeMailer < ApplicationMailer
  def booking_confirmation(attendee)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @attendee = attendee
    @user = @attendee.employee
    @event = @attendee.event
    mail(to: @user.email, subject: 'Confirmation de votre Seance avec Zenest.pro !')
  end

  def reminder_a_day_before(employee, attendees)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @employee = employee
    @attendees = attendees
    mail(to: @employee.email, subject: 'Rappel de vos prestations avec Zenest.pro')
  end

  def reminder_30_min_before(employee, attendee)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @employee = employee
    @attendee = attendee
    mail(to: @employee.email, subject: 'Rappel de votre Seance avec Zenest.pro')
  end

  def cancellation_event(attendee)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @employee = attendee.employee
    @event = attendee.event
    mail(to: @employee.email, subject: 'Annulation de votre séance avec Zenest.pro')
  end
end
