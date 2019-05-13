class Praticien::RegistrationsController < Devise::RegistrationsController
  before_action :set_praticien, only: [:edit, :update]
  def edit
    render layout: "dashboard"
  end

  def update
    resource = @praticien.user
    self.resource = resource_class.to_adapter.get!(send(:"current_user").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    @praticien.assign_attributes(praticien_edit_params)
    yield resource if block_given?
    if @praticien.valid? && update_resource(resource, user_edit_params[:user_attributes])
      @praticien.save
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      render layout: "dashboard", action: :edit
    end
  end

  private

  def user_edit_params
    params.require(:praticien).permit(user_attributes: [ :id, :first_name, :last_name, :birthday, :address, :complement, :zipcode, :city, :phone, :email, :password, :password_confirmation, :current_password ])
  end

  def praticien_edit_params
    params.require(:praticien).permit(:photo)
  end

  def set_praticien
      @praticien = current_user.actable
  end

  def after_update_path_for(resource)
    sign_in_after_change_password? ? praticien_events_path(resource) : new_session_path(resource_name)
  end

  def set_flash_message_for_update(resource, prev_unconfirmed_email)
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                  :update_needs_confirmation
                elsif sign_in_after_change_password?
                  :updated
                else
                  :updated_but_not_signed_in
                end
    set_flash_message :notice, flash_key
  end

  def sign_in_after_change_password?
    return true if account_update_params[:password].blank?
  end
end
