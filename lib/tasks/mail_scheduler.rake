namespace :mail_scheduler do
  desc "This task is called by the Heroku scheduler add-on to send reminder_a_day_before mail to employee"
  task :send_emails_to_employee_reminder_a_day_before => :environment do
    tomorrow = (DateTime.now + 1).to_date
    # Recherche de tous les attendees qui ont lieu demain
    attendees_tomorrow = Attendee.confirmed.joins(:event)
                                .where('DATE(events.start_date) = ?', tomorrow)
                                .group_by_employee
     attendees_tomorrow.each do |employee, attendees|
      EmployeeMailer.reminder_a_day_before(employee, attendees).deliver_now
    end
  end

  desc "This task is called by the Heroku scheduler add-on to send reminder_a_day_before mail to praticien"
  task :send_emails_to_praticien_reminder_a_day_before => :environment do
    tomorrow = (DateTime.now + 1).to_date
    # Recherche de tous les event qui ont lieu demain
    events_tomorrow = Event.active.where('DATE(events.start_date) = ?', tomorrow)
    # Les praticiens associées
    praticiens = Praticien.includes(:events).where(events: events_tomorrow).distinct

    praticiens.each do |praticien|
      events = events_tomorrow.where(praticien: praticien)
      company = events.first.company
      PraticienMailer.reminder_a_day_before(praticien, events, company).deliver_now
    end
  end

  desc "This task is called by the Heroku scheduler add-on to send reminder the day d mail to praticien"
  task :send_emails_to_praticien_reminder_day_d => :environment do
    today = (DateTime.now).to_date
    events_today = Event.active.where('DATE(events.start_date) = ?', today)
    praticiens = Praticien.includes(:events).where(events: events_today).distinct
    praticiens.each do |praticien|
      events = events_today.where(praticien: praticien)
      company = events.first.company
      PraticienMailer.reminder_day_d(praticien, events, company).deliver_now
    end
  end

end
