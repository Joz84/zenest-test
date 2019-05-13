class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.deliver
      flash[:notice] = 'Merci pour votre message. Nous vous répondrons dès que possible.'
      redirect_to new_contact_path
    else
      flash[:error] = "Erreur dans vos données"
      render :new
    end
  end

  private

  def contact_params
    params.required(:contact).permit(:email, :first_name, :last_name, :company, :phone, :message)
  end

end
