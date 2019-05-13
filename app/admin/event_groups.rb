ActiveAdmin.register EventGroup do
  menu false
  actions :index, :show, :new, :create

  controller do
    include InheritedResources::DSL
    create! do |success, failure|
      success.html {
        redirect_to admin_typical_days_path(event_group_id: resource.id)
      }
    end
  end

  permit_params :calendar,
                :calendar_id,
                :title,
                :massage_category_id,
                :massage_category,
                :room,
                :description,
                :price,
                :duration,
                :massage_by_slot,
                :morning_date,
                :morning_duplication,
                :afternoon_date,
                :afternoon_duplication,
                :max_attendees,
                :min_attendees

  form do |f|
    f.semantic_errors
    f.object.calendar = Calendar.first
    f.inputs do
      f.input :title
      f.input :massage_category
      # f.input :room
      f.input :calendar, as: :select, collection: Calendar.all.map { |calendar| ["#{calendar.name} - #{calendar.company.name}", calendar.id]}, selected: Calendar.find(params[:calendar_id]).id
      f.input :description
      f.input :price
      f.input :duration, label: "Duration in min"
      f.input :massage_by_slot
      f.input :morning_date, as: :time_picker, label: "Horaire de Départ le matin"
      f.input :morning_duplication, input_html: { value: 0 }
      f.input :afternoon_date, as: :time_picker, label: "Horaire de Départ l'après-midi'"
      f.input :afternoon_duplication, input_html: { value: 0 }
      f.input :max_attendees
      f.input :min_attendees
      f.button :submit
    end
  end

end
