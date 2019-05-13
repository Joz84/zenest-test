# Bug pour la création d'un praticien

ActiveAdmin.register Praticien do
  config.sort_order = 'id_asc'

    controller do
    def update
      if params[:praticien][:user_attributes][:password].blank? && params[:praticien][:user_attributes][:password_confirmation].blank?
        params[:praticien][:user_attributes].delete("password")
        params[:praticien][:user_attributes].delete("password_confirmation")
      end
      super
    end
  end

  user_attributes = [
      :_destroy,
      :id,
      :first_name,
      :last_name,
      :address,
      :email,
      :password,
      :password_confirmation,
      :zipcode,
      :city,
      :complement,
      :phone,
      :birthday,
      :actable_type,
      :actable_id
    ]
  permit_params :photo, :remote_photo_url, :photo_cache, :gender,
      user_attributes: user_attributes, massage_category_ids: []

  filter :by_city_in,
    as: :select,
    label: 'City',
    collection: proc { User.ransaker_filter_by_and_ordered_by("Praticien", :city) }
  filter :by_last_name_in,
    as: :select,
    label: 'Last_Name',
    collection: proc { User.ransaker_filter_by_and_ordered_by("Praticien", :last_name) }
  filter :by_first_name_in,
    as: :select,
    label: 'First_Name',
    collection: proc { User.ransaker_filter_by_and_ordered_by("Praticien", :first_name) }
  filter :massage_categories

  form do |f|
    tabs do
      tab 'Détails Praticien' do
        f.inputs do
          f.inputs "user", for: [:user, f.object.user || User.new] do |user|
            user.input :email
            user.input :password
            user.input :password_confirmation
            user.input :first_name
            user.input :last_name
            user.input :address
            user.input :zipcode
            user.input :city
            user.input :complement
            user.input :phone
            user.input :birthday, as: :datepicker
            # user.input :actable_type, input_html: { value: f.object.class }, as: :hidden
            # user.input :actable_id, input_html: { value: f.object.id }, as: :hidden
          end
          f.input :gender
          f.input :photo, as: :file, hint: cl_image_tag(f.object.photo.url), label: "Importer une photo"
          f.input :remote_photo_url, label: "Photo URL"
          f.input :photo_cache, as: :hidden
          f.button :submit
        end
      end
      tab "Compétences" do
        f.inputs do
          f.input :massage_categories, as: :check_boxes, collection: MassageCategory.all.map { |massage_category| [massage_category.name, massage_category.id]}
          f.button :submit
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column :email
    column :last_name
    column :first_name
    tag_column :gender
    column :zipcode
    column :city
    column "Competencies" do |p|
      p.massage_categories.map(&:name).join(", ")
    end
    actions
  end

  show do |a|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :address
      row :zipcode
      row :city
      row :gender
    end
    panel "Factures" do
      table_for praticien.invoices do
        column :id
        column :date
        column :reference
        column "Montant" do |p|
          "#{humanized_money p.amount}"
        end
        column :url
        column :status
        column "Voir" do |invoice|
          link_to "PDF", "#{cl_private_download_url("#{invoice.reference}_#{invoice.invoiceable_type}_#{invoice.invoiceable_id.to_s}", :pdf)}"
        end
      end
    end
    panel "Disponibilités" do
      table_for praticien.availabilities do
        column :id
        column :status
        column "Date" do |attendee|
          "#{attendee.requirement.calendar_day.date}"
        end
        column "MassageCategory" do |attendee|
          "#{attendee.requirement.massage_category.name}"
        end
        column "Montant proposé" do |attendee|
          "#{humanized_money attendee.requirement.amount}"
        end
      end
    end
  end
end
