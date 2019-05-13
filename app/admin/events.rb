# Fields of the model
# :start_date
# :end_date
# :massage_category, foreign_key: true
# :room, foreign_key: true
# :calendar_day, foreign_key: true
# :praticien, foreign_key: true
# :description
# :photo
# :price
# :status
# :title
# :max_attendees
# :min_attendees

 ActiveAdmin.register Event do
   config.sort_order = 'start_date_desc'
   permit_params :start_date,
                 :end_date,
                 :massage_category,
                 :massage_category_id,
                 :room,
                 :calendar_day,
                 :praticien,
                 :praticien_id,
                 :description,
                 :photo,
                 :price,
                 :status,
                 :title,
                 :max_attendees,
                 :min_attendees,
                 :remote_photo_url

   actions :index, :show, :edit, :destroy, :update

   # filter :by_company_name_in,
   #  as: :select,
   #  label: 'Company',
   #  collection: proc { Company.ransaker_ordered_by(:name) }

  filter :start_date
  filter :massage_category
  filter :praticien

  index do
    selectable_column
    column "N°", :id
    column :company
    column "Date" do |event|
      event.complete_date
    end
    column :massage_category
    column :praticien
    column "Status Calendrier" do |event|
      event.calendar.active ? "active" : "en attente"
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :start_date, as: :datetime_picker
      f.input :end_date, as: :datetime_picker
      f.input :massage_category
      f.input :title
      f.input :price
      f.input :room
      f.input :praticien
      f.input :description
      # f.input :photo, as: :file, hint: cl_image_tag(f.object.photo.url), label: "Importer une photo"
      # f.input :remote_photo_url, label: "Photo URL"
      f.button :submit
    end
  end
end
