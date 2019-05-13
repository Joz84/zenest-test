ActiveAdmin.register_page "Typical Days" do
  menu false
  content do
    @event_group = EventGroup.find(params[:event_group_id])
    @morning_default_events = @event_group.default_events.order(start_date: :asc).where(morning: true)
    @afternoon_default_events = @event_group.default_events.order(start_date: :asc).where(morning: false)
    render "index", morning_default_events: @morning_default_events,
                    afternoon_default_events: @afternoon_default_events,
                    event_group: @event_group
  end

end
