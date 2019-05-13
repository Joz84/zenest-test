# Bug pour la création d'un employee
ActiveAdmin.register Employee do
  config.sort_order = 'id_asc'

  before_create do |employee|
    employee.employee_code = employee.company.company_code
  end

  controller do
    def update
      resource.employee_code = resource.company.company_code
      if params[:employee][:user_attributes][:password].blank? && params[:employee][:user_attributes][:password_confirmation].blank?
        params[:employee][:user_attributes].delete("password")
        params[:employee][:user_attributes].delete("password_confirmation")
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

  permit_params :company, :company_id, :admin_company, :matricule, :stripe_id, :complement_infos,
      :conditions_validation, user_attributes: user_attributes

  filter :company
  filter :by_last_name_in,
    as: :select,
    label: 'Last_Name',
    collection: proc { User.ransaker_filter_by_and_ordered_by("Employee", :last_name) }
  filter :user_last_name
  filter :admin_company

  form do |f|
    tabs do
      tab 'Employee' do
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
          f.input :admin_company
          f.input :matricule
          f.input :stripe_id
          f.input :complement_infos
          f.input :company, as: :select, collection: Company.all
          #f.input :employee_code, as: :select, collection: Company.all.map { |company| [company.name, company.company_code] }
          f.input :conditions_validation
          f.button :submit
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column :last_name
    column :first_name
    column :company
    column :admin_company
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row 'company' do |employee|
        "#{employee.company.name}"
      end
      row :admin_company
    end
    panel "Bilan des prestations réservées" do
      table_for employee.attendees do
        column :id
        column "Date" do |attendee|
          "#{attendee.event.complete_date}"
        end
        column "MassageCategory" do |attendee|
          "#{attendee.event.massage_category.name}"
        end
        column :status
      end
    end
  end

end
