# Fields of the model
# t.string :title
# t.text :content
# t.string :slug
# t.string :photo
# t.datetime :published_at
# t.references :blog_author, foreign_key: true

ActiveAdmin.register BlogArticle do
  config.sort_order = 'published_at_asc'

  permit_params :title, :content, :photo, :remote_photo_url, :status, :published_at, :author, blog_tag_ids: [],
      blog_meta_attributes: [:_destroy, :id, :title, :content, :blog_article_id]

  filter :title
  filter :blog_tags
  filter :status
  filter :published_at

  form do |f|
    tabs do
      tab 'Article' do
        f.inputs do
          f.input :title
          f.input :content, as: :ckeditor
          f.input :photo, as: :file, hint: cl_image_tag(f.object.photo.url), label: "Importer une photo"
          f.input :remote_photo_url, label: "Photo URL"
          f.input :photo_cache, as: :hidden
          f.input :published_at, as: :datepicker
          f.input :author
          f.input :status
          f.input :blog_tags, as: :check_boxes, collection: BlogTag.all
          f.button :submit
        end
      end
      tab 'Données Meta de l Article' do
        f.inputs do
          f.has_many :blog_meta, heading: 'Meta Details', allow_destroy: true do |meta|
            meta.input :title, collection: ['title', 'description', 'image']
            meta.input :content
          end
        f.button :submit
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column "Titre", :title
    column "Date de publication" do |article|
      "#{article.published_at.strftime('%d/%m/%Y')}"
    end
    column :status
    column "Tags" do |article|
      article.blog_tags.display_tags
    end
    actions
  end

  show do |a|
    attributes_table do
      row :slug
      row :title
      row :content
      row :photo
      row :status
      row :published_at
      row :author
    end
  end
end
