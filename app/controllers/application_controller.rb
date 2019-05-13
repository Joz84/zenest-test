class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    user_data = [
      :first_name,
      :last_name,
      :address,
      :zipcode,
      :city,
      :complement,
      :phone,
      :birthday,
      :actable_type,
      :actable_id

    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: user_data)
    devise_parameter_sanitizer.permit(:account_update, keys: user_data)
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

   # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisés à réaliser cette action."
    redirect_to(root_path)
  end

  private
  def sign_in_path(user)
    if current_user.admin_employee?
      admin_employee_events_path
    elsif current_user.employee?
      new_employee_attendee_path
    elsif current_user.praticien?
      praticien_events_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    sign_in_path(resource)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^contacts$)|(^blog_articles$)/
  end
end
