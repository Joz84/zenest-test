class Contact < MailForm::Base
  attribute :last_name,      validate: true
  attribute :first_name
  attribute :company,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone
  attribute :message,   validate: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Demande de devis depuis zenest.pro",
      :to => "etienne@zenest.com",
      :from => %("#{last_name} #{first_name}" <#{email}>)
    }
  end

end
