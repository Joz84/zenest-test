ActiveAdmin.register MassageCategory do
  config.sort_order = 'name_asc'

  permit_params :name, :photo, :price, :price_cents, :individual, :photo_cache, :remote_photo_url

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :photo, as: :file, hint: cl_image_tag(f.object.photo.url), label: "Importer une photo"
      f.input :remote_photo_url, label: "Photo URL"
      f.input :photo_cache, as: :hidden
      f.input :price
      f.input :individual
      f.button :submit
    end

  end

  index do
    selectable_column
    column :id
    column "Nom", :name
    column "Prix par séance" do |p|
      "#{humanized_money p.price}"
    end
    column :individual
    actions
  end

  show do |a|
    attributes_table do
      row :id
      row :name
      row "Price" do |p|
        "#{humanized_money p.price}"
      end
      row :individual
    end
    panel "Praticiens de cette catégorie" do
      table_for massage_category.praticiens do
        column :id
        column :first_name
        column :last_name
        column :city
        column :phone
        column :gender
      end
    end
  end

end
