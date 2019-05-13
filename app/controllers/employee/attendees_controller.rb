class Employee::AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new
    authorize([:employee, @attendee])
    @massage_categories = current_user.actable
                                      .active_events
                                      .formated_for_calendar
                                      .to_json
    render layout: "dashboard"
  end

  def create
    @attendee = current_user.actable.attendees.new(attendee_params)
    authorize ([:employee, @attendee])
    @event = @attendee.event
    if @attendee.save
      begin
        if @event.calendar.payable
          charge = Stripe::Charge.create(charge_params(@event))
          @attendee.update(payment_json: charge.to_json)
        end
        EmployeeMailer.booking_confirmation(@attendee).deliver_now
        redirect_to employee_events_path
      rescue => e
        flash[:alert] = "Une erreur avec le système de paiement s'est produite"
        StripeMailer.errors(e.message, @attendee).deliver_now
        @attendee.destroy
        @massage_categories = current_user.actable.active_events.formated_for_calendar.to_json
        render "employee/attendees/new", layout: "dashboard"
      end
    else
      @massage_categories = current_user.actable.active_events.formated_for_calendar.to_json
      flash[:alert] = @attendee.errors.messages.values.flatten.join('. ');
      render "employee/attendees/new", layout: "dashboard"
    end
  end

  def update
    @attendee = Attendee.find(params[:id])
    authorize ([:employee, @attendee])
    unless @attendee.update( status: params[:status].to_i )
      flash[:alert] = @attendee.errors.messages.values.flatten.join('. ');
    end
    redirect_to employee_events_path
  end

  private

  def attendee_params
    params.required(:attendee).permit(:event_id)
  end

  def charge_params(event)
    {
      customer: current_user.actable.stripe_id,
      source: params[:stripeToken],
      amount: event.price_cents,
      currency: event.price.currency,
      description:  "Participation à une séance de #{event.massage_category.name} le #{event.start_date} avec #{event.praticien.name}",
    }
  end
end

