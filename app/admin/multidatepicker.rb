ActiveAdmin.register_page "Multidatepicker" do
  menu false
  content do
    @event_group = EventGroup.find(params[:event_group_id])
    render "index", event_group: @event_group
  end

end
