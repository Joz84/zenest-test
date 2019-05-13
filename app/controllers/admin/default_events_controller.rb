class Admin::DefaultEventsController < ApplicationController
  def create
    duration = default_event_params[:duration]
    massage_by_slot = default_event_params[:massage_by_slot].to_i
    duplication = default_event_params[:duplication].to_i
    @default_event = DefaultEvent.new(default_event_params)
    @default_event.end_date = @default_event.start_date.to_datetime + duration
    if @default_event.valid?
      massage_by_slot.times do
        duplication.times do |i|
          start_date = @default_event.start_date.to_datetime + duration * i
          end_date = start_date + duration
          DefaultEvent.create!(
            event_group: @default_event.event_group,
            massage_category: @default_event.massage_category,
            start_date: start_date,
            end_date: end_date,
            description: @default_event.description,
            price: @default_event.price,
            price_currency: "EUR",
            title: @default_event.title,
            max_attendees: @default_event.max_attendees,
            min_attendees: @default_event.min_attendees,
            morning: start_date.hour < 12
          )
        end
      end
      flash[:alert] = "Nouvel événement créé"
    else
      flash[:alert] = @default_event.errors.messages
    end
    redirect_to admin_typical_days_path(event_group_id: @default_event.event_group_id)
  end

  def update
    duration = default_event_params[:duration]
    @default_event = DefaultEvent.find(params[:id])
    @event_group = @default_event.event_group
    end_date = @default_event.start_date.to_datetime + duration
    if @default_event.update(default_event_params.merge( end_date: end_date ))
      flash[:alert] = "L'événement à bien été modifié"
    else
      flash[:alert] = @default_event.errors.messages
    end
    redirect_to admin_typical_days_path(event_group_id: @event_group.id)
  end

  def destroy
    @default_event = DefaultEvent.find(params[:id])
    @event_group = @default_event.event_group
    @default_event.destroy
    flash[:alert] = "L'événement à bien été effacé"
    redirect_to admin_typical_days_path(event_group_id: @event_group.id)
  end

  private

  def default_event_params
    parameters = params.require(:default_event).permit(
      :event_group_id,
      :massage_category,
      :massage_category_id,
      :start_date,
      :end_date,
      :description,
      :price,
      :price_currency,
      :title,
      :max_attendees,
      :min_attendees,
      :massage_by_slot,
      :duplication,
      :duration
    )
    parameters[:duration] = parameters[:duration].to_i.minutes
    # parameters[:max_attendees] = parameters[:max_attendees].to_i
    # parameters[:min_attendees] = parameters[:min_attendees].to_i
    parameters
  end
end
