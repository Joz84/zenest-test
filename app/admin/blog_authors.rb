# Fields of the model
# t.string :first_name
# t.string :last_name


ActiveAdmin.register BlogAuthor do
  permit_params :first_name, :last_name
  form do |f|
    f.inputs do
      f.input :last_name
      f.input :first_name
      f.button :submit
    end
  end

  index do
    selectable_column
    column :id
    column :last_name
    column :first_name
    actions
  end
end
