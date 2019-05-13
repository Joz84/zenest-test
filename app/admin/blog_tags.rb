ActiveAdmin.register BlogTag do
  permit_params :name

  form do |f|
    f.inputs do
      f.input :name
      f.button :submit
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :slug
    actions
  end
end
