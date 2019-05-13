# t.string :title
# t.string :pdf
# t.datetime :date
# t.references :invoiceable, polymorphic: true
# t.string :reference
# t.monetize :amount

ActiveAdmin.register Invoice do
  config.sort_order = 'invoiceable_type_asc'

  permit_params :title, :pdf, :date, :invoiceable_type, :invoiceable_id, :reference, :amount, :amount_cents


  # actions :index, :show, :edit, :new

  filter :invoiceable_type
  filter :invoiceable_id
  filter :reference
  filter :by_company_name_in,
    as: :select,
    label: 'Company',
    collection: proc { Company.ransaker_ordered_by(:name) }
  filter :by_praticien_last_name_in,
    as: :select,
    label: 'Praticien',
    collection: proc { User.ransaker_filter_by_and_ordered_by("Praticien", :last_name) }
  # filter :by_praticien_in,
  #   as: :select,
  #   label: 'Praticien',
  #   collection: proc { Invoice.ransaker_ordered_by(:last_name) }

  index do
    selectable_column
    column "N°", :id
    column :title
    column :reference
    column "Prix (en €)" do |invoice|
      invoice.amount
    end
    column "Type", :invoiceable_type
    column "Auteur" do |invoice|
      invoice.owner
    end
    column :status
    column "Voir" do |invoice|
      link_to "PDF", "#{cl_private_download_url("#{invoice.reference}_#{invoice.invoiceable_type}_#{invoice.invoiceable_id.to_s}", :pdf)}"
    end
    div :class => "panel" do
      h3 "Total des factures ci-dessous : #{humanized_money Invoice.search(params[:q]).result.sum(:amount_cents) * 1.0 / 100} €"
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :reference
      f.input :date, as: :datepicker
      f.input :amount
      f.input :pdf, as: :file
      f.input :invoiceable_type, as: :select,
              collection: ["Company", "Praticien"],
              label: "Type de Facture"
      f.input :invoiceable,
                label: "Company ou Praticien", as: :select,
                collection: Company.all.to_a.push(Praticien.all).flatten,
                include_blank: false
      f.button :submit
    end
  end

end
