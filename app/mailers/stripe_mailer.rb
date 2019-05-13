class StripeMailer < ApplicationMailer

  def errors(e, attendee)
    attachments.inline['logo_zenest.jpg'] = File.read('app/assets/images/logo_zenest.jpg')
    @error = e
    @attendee = attendee
    mail( to: ["etienne@zenest.com", "contact@mihivai.com"], subject: "Erreurs Stripe #{@name} - Zenest.pro")
  end
end
