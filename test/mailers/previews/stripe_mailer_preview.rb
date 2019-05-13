# Preview all emails at http://localhost:3000/rails/mailers/stripe_mailer
class StripeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/stripe_mailer/errors
  def errors
    StripeMailer.errors
  end

end
