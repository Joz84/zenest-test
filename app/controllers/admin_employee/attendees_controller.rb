class AdminEmployee::AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new
    authorize ([:admin_employee, @attendee])
    render layout: "dashboard"
  end

  # cas ou c'est l'employee qui paye non géré
  def create
    @attendee = Attendee.new(attendee_params)
    @attendee.event = Event.find(params[:event_id])
    authorize ([:admin_employee, @attendee])
    if @attendee.save
      flash[:notice] = "#{@attendee.employee.name} ajouté avec succès à cette prestation"
      EmployeeMailer.booking_confirmation(@attendee).deliver_now
      redirect_to admin_employee_event_path(@attendee.event)
    else
      @event = @attendee.event
      flash.now[:alert] = "Cette personne ne peut pas être ajoutée à cette prestation."
      render "admin_employee/events/show", layout: "dashboard"
    end
  end

  def update
    @attendee = Attendee.find(params[:id])
    authorize ([:admin_employee, @attendee])
    @attendee.status = params[:status].to_i
    if @attendee.save
      flash[:notice] = "L'inscription de #{@attendee.employee.name} a été modifiée avec succès"
      #Mailer pour confirmer le passage en status annulé pour V1
      redirect_to admin_employee_event_path(@attendee.event)
    else
      @event = @attendee.event
      flash.now[:alert] = "L'annulation à cette prestation n'est pas possible"
      render "admin_employee/events/show", layout: "dashboard"
    end
  end

  private

  def attendee_params
    params.required(:attendee).permit(:status, :employee_id)
  end
end
