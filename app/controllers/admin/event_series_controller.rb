class Admin::EventSeriesController < ApplicationController
  def create
    @event_group = EventGroup.find(params[:event_group_id])
    @event_dates = params[:event_series].split(",")
    @event_dates.each do |event_date|
      date = Date.parse(event_date)
      calendar_day = CalendarDay.find_or_create_by(
        date: date,
        calendar: @event_group.calendar
      )
      @event_group.default_events.each do |default_event|
        start_date = default_event.start_date.change(
          year: date.year,
          month: date.month,
          day: date.day
        )
        end_date = default_event.end_date.change(
          year: date.year,
          month: date.month,
          day: date.day
        )
        Event.create(
          start_date: start_date,
          end_date: end_date,
          massage_category: default_event.massage_category,
          calendar_day: calendar_day,
          description: default_event.description,
          price: default_event.price,
          price_currency: "EUR",
          status: 0,
          title: default_event.title,
          max_attendees: default_event.max_attendees,
          min_attendees: default_event.min_attendees,
          event_group: @event_group
        )
      end
    end
    redirect_to edit_admin_calendar_path(@event_group.calendar)
  end
end
