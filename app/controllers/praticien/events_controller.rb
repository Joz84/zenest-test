
class Praticien::EventsController < ApplicationController
  def index
    @events = policy_scope([:praticien, Event])
    authorize([:praticien, Event])
    render layout: "dashboard"
  end

  def print
    @events = Event.filtered_by_praticien(current_user)
    authorize([:praticien, @events])
    render layout: "dashboard"
  end

  def print_planning_day
    @date = params[:print_pdf][:date]
    @events = Event.filtered_by_praticien(current_user).filtered_by_date(@date).ordered_by_start_date
    if @date.present? && @events.present?
      authorize([:praticien, @events])
      respond_to do |format|
        format.html
        format.pdf {render  pdf: "Planning Zenest #{@date}", disposition: 'attachment' }
      end
    else
      redirect_to praticien_print_path, alert: "Veuillez saisir une date disponible dans votre calendrier"
    end
  end
end

