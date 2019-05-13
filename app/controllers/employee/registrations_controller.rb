# frozen_string_literal: true

class Employee::RegistrationsController < Devise::RegistrationsController
  before_action :set_employee, only: [:edit, :update]

  def new
    @employee = Employee.new
    @employee.build_user
    yield resource if block_given?
  end

  def create
    company_code =  employee_params[:employee_code]
    @employee = Employee.new(employee_params)
    @employee.company = @employee.find_company(company_code)
    resource = @employee.user
    yield resource if block_given?
    if @employee.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end

  def edit
    render layout: "dashboard"
  end

  def update
    resource = @employee.user
    self.resource = resource_class.to_adapter.get!(send(:"current_user").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    @employee.assign_attributes(employee_edit_params)
    yield resource if block_given?
    if @employee.valid? && update_resource(resource, user_edit_params[:user_attributes])
      @employee.save
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

  def employee_params
    params.require(:employee).permit(:matricule, :employee_code, :conditions_validation, :complement_infos, user_attributes: [ :id, :first_name, :last_name, :birthday, :address, :complement, :zipcode, :city, :phone, :email, :password, :password_confirmation ])
  end
  def user_edit_params
    params.require(:employee).permit(user_attributes: [ :id, :first_name, :last_name, :birthday, :address, :complement, :zipcode, :city, :phone, :email, :password, :password_confirmation, :current_password ])
  end

  def employee_edit_params
    params[:employee][:employee_code] = @employee.company.company_code
    params.require(:employee).permit(:complement_infos, :employee_code)
  end

  def set_employee
      @employee = current_user.actable
  end

  def new_registration
      redirect_to(employee_events_path) if user_signed_in?
  end

  def after_update_path_for(resource)
    sign_in_after_change_password? ? employee_events_path(resource) : new_session_path(resource_name)
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
