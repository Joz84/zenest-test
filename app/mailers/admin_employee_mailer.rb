class AdminEmployeeMailer < ApplicationMailer

  def reminder_a_day_before(user, events)
    # Manque events dans la vue à finaliser selon ce qui sera renvoyé par calendar
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @events = events
    mail(to: @user.email, subject: 'Rappel des prestations de demain avec Zenest.pro')
  end

  def calendar_activation(user, calendar)
    # A ajouter dans le modéle Calendar au passage à active envoi du mail
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @user = user
    @calendar = calendar
    mail(to: @user.email, subject: 'De nouveaux créneaux sont disponible avec Zenest.pro')
  end

  def quotation_request_confirmation(mail)
    #Voir comment récupérer le mail avec la gem mailform
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    mail(to: mail, subject: 'Demande de devis sur Zenest.pro')
  end
end
