class AdminEmployee::EventsController < ApplicationController
  def index
    @events = policy_scope([:admin_employee, Event])
    authorize([:admin_employee, Event])
    @massage_categories = current_user.actable
                                      .active_events
                                      .formated_for_calendar
                                      .to_json
    render layout: "dashboard"
  end

  def update
    # Mise à jour uniquement de la salle
    @event = Event.find(params[:id])
    @attendee = Attendee.new
    if @event.update(event_params)
      flash[:notice] = "La salle #{@event.room.name} assigné avec succès à cette prestation"
      redirect_to admin_employee_event_path(@event)
    else
      render layout: 'dashboard', action: :show
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendee = Attendee.new
    authorize([:admin_employee, @event])
    render layout: "dashboard"
  end

  def print
    # @events = .....
    # authorize([:admin_employee, @events])
    @events = Event.filtered_by_calendar_active.filtered_by_company(current_user)
    authorize([:admin_employee, @events])
    render layout: "dashboard"
  end

  def print_planning_day
    # A finaliser avec tableau de Jo
    # @events = calendar active, de la company  selon le scope que Jo aura fait dans index
    # authorize([:admin_employee, @events])
    @date = params[:print_pdf][:date]
    calendar_day = current_user.company.calendar_days.find_by(date: @date)
    @events = current_user.company.events.filtered_by_calendar_day(calendar_day).ordered_by_start_date
    if @date.present? && @events.present?
      authorize([:admin_employee, @events])
      respond_to do |format|
        format.html
        format.pdf {render  pdf: "Planning Zenest #{@date}", disposition: 'attachment' }
      end
    else
      redirect_to admin_employee_print_path, alert: "Veuillez saisir une date disponible dans votre calendrier"
    end
  end

  private
  def event_params
    params.require(:event).permit(:room_id)
  end
end
