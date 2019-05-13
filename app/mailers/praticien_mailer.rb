class PraticienMailer < ApplicationMailer

  def reminder_a_day_before(user, events, company)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @events = events
    @company = company
    mail(to: @user.email, subject: 'Rappel de votre Seance avec Zenest.pro')
  end

  def reminder_day_d(user, events, company)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @events = events
    @company = company
    mail(to: @user.email, subject: 'Rappel de votre journée avec Zenest.pro')
  end

  def availability_request(availability)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = availability.praticien.user
    @availability = availability
    @company = @availability.requirement.calendar_day.calendar.company
    mail(to: @user.email, subject: 'Tu as une nouvelle demande de prestation sur Zenest')
  end

  def availability_feedback_positive(user, requirement)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @requirement = requirement
    @company = @requirement.calendar_day.calendar.company
    mail(to: @user.email, subject: 'Vos prestations avec Zenest.pro')
  end

  def availability_feedback_negative(user, requirement)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @requirement = requirement
    @company = @requirement.calendar_day.calendar.company
    mail(to: @user.email, subject: 'Vos prestations avec Zenest.pro')
  end

  def cancellation_event(event)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @praticien = event.praticien
    @event = event
    mail(to: @praticien.email, subject: 'Annulation de votre prestation avec Zenest.pro')
  end
end
