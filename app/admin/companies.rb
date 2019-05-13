# Fields of the model
# :address
# :zipcode, :string
# :city, :string
# :name*
# :siret
# :logo
# :company_code
# :booking_max
# :active, default: true

ActiveAdmin.register Company do
  config.sort_order = 'name_asc'

  permit_params :name, :address, :siret, :company_code, :email_extension_active, :active, :logo, :zipcode, :city,:logo_cache,
  rooms_attributes: [:_destroy, :id, :name, :capacity],
  invoices_attributes: [:_destroy, :id, :title, :remote_pdf_url, :pdf, :amount, :date, :reference, :pdf_cache],
  calendars_attributes: [:_destroy, :id, :name, :active, :payable, :google_id],
  email_extensions_attributes: [:_destroy, :id, :name],
  booking_restrictions_attributes: [:id, :rate, :periodicity]

  filter :name
  filter :city
  filter :zipcode

  form do |f|
    tabs do
      tab 'Compagnie' do
        f.inputs do
          f.input :name
          f.input :siret
          f.input :address
          f.input :zipcode
          f.input :city
          f.input :email_extension_active
          # f.input :active
          f.input :logo, as: :file, hint: cl_image_tag(f.object.logo.url)
          f.input :logo_cache, as: :hidden
          f.button :submit
        end
      end
      tab "Salles" do
        f.inputs do
          f.has_many :rooms, heading: 'Salles Disponible', allow_destroy: true do |room|
            room.input :name
            room.input :capacity
          end
        f.button :submit
        end
      end
      tab "Restrictions" do
        f.inputs do
          f.has_many :booking_restrictions, heading: 'Nb de Réservations Authorisées' do |booking_restriction|
            booking_restriction.input :massage_category
            booking_restriction.input :rate, placeholder: 'ex : 4'
            booking_restriction.input :periodicity, placeholder: 'ex : 4'
          end
        f.button :submit
        end
      end
      tab "Email Extensions" do
        f.inputs do
          f.has_many :email_extensions, heading: 'Email Extensions', allow_destroy: true do |email|
            email.input :name, placeholder: 'ex : gmail.com'
          end
        f.button :submit
        end
      end
      tab "Factures" do
        f.inputs do
          f.has_many :invoices, heading: 'Factures', allow_destroy: true do |invoice|
            invoice.input :invoiceable_type, input_html: { value: f.object.class }, as: :hidden
            invoice.input :title
            invoice.input :remote_pdf_url, label: "PDF URL"
            invoice.input :pdf, label: "Download PDF"
            invoice.input :pdf_cache, as: :hidden
            invoice.input :amount
            invoice.input :reference
            invoice.input :date, as: :datepicker
            # invoice.input :status, as: :select
          end
        f.button :submit
        end
      end
      tab "Calendriers" do
        f.inputs do
          f.has_many :calendars, heading: 'Calendriers', allow_destroy: true do |calendar|
            calendar.input :name
            calendar.input :active
            calendar.input :payable
          end
        f.button :submit
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column :company_code
    column :name
    column :zipcode
    column :city
    actions
  end

  show do |a|
    attributes_table do
      row :id
      row :company_code
      row :name
      row :city
      row :address
      row :zipcode
      row :email_extension_active
      row :active
    end
    panel "Email Extensions" do
      table_for company.email_extensions do
        column :name
      end
    end
    panel "Restrictions de Réservations" do
      table_for company.booking_restrictions do
        column "Massage Category" do |booking_restriction|
          booking_restriction.massage_category.name
        end
        column "Nb de Réservations Authorisées" do |booking_restriction|
          "#{booking_restriction.rate} par #{booking_restriction.periodicity}"
        end

      end
    end
    panel "Factures associés" do
      table_for company.invoices do
        column :id
        column :title
        column :amount
        column :reference
        column :date
        column "Voir" do |invoice|
          link_to "PDF", "#{cl_private_download_url("#{invoice.reference}_#{invoice.invoiceable_type}_#{invoice.invoiceable_id.to_s}", :pdf)}"
        end
      end
    end
    panel "Calendriers" do
      table_for company.calendars do
        column :id
        column :name
        column :active
        column :payable
      end
    end
    panel "Salles Disponibles" do
      table_for company.rooms do
        column :name
        column :capacity
      end
    end
  end

end
