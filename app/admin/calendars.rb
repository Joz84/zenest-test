# Fields of the model
# :company, foreign_key: true
# :google_id
# :active
# :name
# :payable

require 'active_admin/resource_controller'

ActiveAdmin.register Calendar do
# See permitted parameters documentation:
  config.sort_order = 'name_asc'

  actions :index, :show, :edit, :new, :update, :create

  permit_params :name, :active, :payable, :company_id,
  calendar_days_attributes: [:_destroy, :id, :name, :date,
    requirements_attributes: [:destroy, :id, :massage_category_id, :amount,
      availabilities_attributes: [:destroy, :id, :praticien_id, :status],
      praticien_ids: []
    ]
  ],
  events_attributes: [:_destroy, :id, :massage_category_id, :praticien_id, :description, :price, :event_group_id],
  event_groups_attributes: [:_destroy, :id, :title, :massage_category_id, :room_id, :description, :price, :duration, :massage_by_slot, :morning_date, :morning_duplication, :afternoon_date, :afternoon_duplication, :max_attendees, :min_attendees, :capacity ],
  availabilities_attributes: [:destroy, :id, :praticien_id, :status]
  # , requirements_attributes: [:destroy, :id, praticiens_booked_ids: []
  # ]

  filter :company
  filter :name
  filter :payable
  filter :active, as: :select

  index do
    selectable_column
    column :id
    column :name
    column "Company name" do |calendar|
      calendar.company.name
    end
    column "Prestations" do |calendar|
      events = calendar.events.ordered_by_start_date
      if events.present?
        "du #{l(events.first&.start_date, format: :short)} au #{l(events.last&.end_date, format: :short) }"
        # "du #{events.first&.start_date.strftime("%A %d %B %Y")} au #{events.last&.end_date.strftime("%A %d %B %Y")}"
      else
        "0 prestation enregistrée"
      end
    end
    column :active
    column :payable
    actions
  end

  show do |a|
    attributes_table do
      row :id
      row :name
      row :active
      row :payable
      # row "company" {|calendar| calendar.company.name}
    end
    panel "Company" do
      table_for calendar.company do |company|
        column :name
        column :city
        column :company_code
      end
    end
    panel "Events" do
      table_for calendar.events.ordered_by_start_date do
        column :id
        column "Créneaux" do |event|
          "Le #{event.start_date.strftime('%d/%m/%Y de %Hh%M ')}#{event.end_date.strftime('à %Hh%M')}"
        end
        column :massage_category
        # column :rooms
        column :praticien
        column :max_attendees
        column "Event" do |event|
          link_to "Modifier l'event", edit_admin_event_path(event)
        end
      end
    end
    panel "Demande de Disponibilités" do
      table_for calendar.availabilities do
        column :id
        column :praticien
        column :status
        column "Date" do |availability|
          "#{l(availability.calendar_day.date, format: :long)}"
        end
      end
    end

  end


  form do |f|
    tabs do
      tab 'Calendar' do
        f.inputs do
          f.input :name
          f.input :company, as: :select
          f.input :active
          f.input :payable
          f.button :submit
        end
      end
      tab "Event_Group" do
        link_to "Créer des prestations", new_admin_event_group_path(calendar_id: calendar.id), class: "admin-btn-success admin-btn-fix-width"
        # f.inputs do
        #   f.has_many :event_groups, heading: 'Event Groups', allow_destroy: true do |event_group|
        #     event_group.input :title
        #     # event_group.input :massage_category
        #     # event_group.input :room
        #     event_group.input :description
        #     event_group.input :price
        #     event_group.input :duration
        #     event_group.input :massage_by_slot
        #     event_group.input :morning_date
        #     event_group.input :morning_duplication
        #     event_group.input :afternoon_date
        #     event_group.input :afternoon_duplication
        #     event_group.input :max_attendees
        #     event_group.input :min_attendees
        #   end
        # f.button :submit
        # end
        #render "event_groups", event_groups: calendar.event_groups
      end
      tab "Demande Dispo Praticiens" do
        f.inputs do
          f.has_many :calendar_days, heading: 'Journées prévues au Calendrier' do |calendar_day|
            calendar_day.template.concat "<p><strong>Journée du #{calendar_day.object.date}</strong></p>".html_safe
            calendar_day.template.concat "
            <p><strong>Prestations prévus : </strong></p>
            <ul> #{calendar_day.object.display_events_date}</ul>".html_safe
            calendar_day.has_many :requirements, heading: 'Demande de dispo', allow_destroy: true do |requirement|
              requirement.input :massage_category
              requirement.input :amount
              requirement.input :praticiens, collection: Praticien.all #filtered_by_competency(params[:massage_category])
              # , collection: Praticien.filtered_by_competency(massage_category)
            end
          end
        f.button :submit
        end
      end
      tab "Validation des praticiens par prestation" do
        f.inputs do
          # A conserver pour nouvelle demande d'Etienne
          # f.has_many :requirements do |requirement|
          #   requirement.template.concat "<p><strong>#{requirement.object.massage_category.name} -
          #   Journée du #{requirement.object.calendar_day} - #{requirement.object.id}</strong></p>".html_safe
          #   requirement :booked_praticiens, as: :select,
          #       label: "Sélectionner un praticien parmi les praticiens disponible :",
          #       collection: Praticien.filtered_by_requirement(requirement.object).filtered_by_available_availabilities
          # end

          f.has_many :events, heading: 'Prestations prévues au Calendrier' do |event|
            event.template.concat "<p><strong>#{event.object.massage_category.name if event.object.massage_category} -
            du #{event.object.complete_date if event.object.start_date} - #{event.object.id}</strong></p>".html_safe
            event.input :praticien, as: :select,
                label: "Sélectionner un praticien parmi les praticiens disponible :",
                collection: Praticien.filtered_by_requirements(event.object).filtered_by_available_availabilities,
                include_blank: true,
                allow_blank: true
          end
        f.button :submit
        end
      end
    end
  end
end
