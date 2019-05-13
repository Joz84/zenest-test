puts 'Delete data'
Availability.destroy_all
Requirement.destroy_all
BookingRestriction.destroy_all
Invoice.destroy_all
Attendee.destroy_all
Event.destroy_all
CalendarDay.destroy_all
Calendar.destroy_all
AdminUser.destroy_all
User.destroy_all
Employee.destroy_all
Competency.destroy_all
Praticien.destroy_all
Company.destroy_all
MassageCategory.destroy_all
BlogMetum.destroy_all
BlogArticleTag.destroy_all
BlogArticle.destroy_all
BlogTag.destroy_all
BlogAuthor.destroy_all

puts 'Create Massage Category'
m1 = MassageCategory.create!(name: "Massage Assis", price_cents: 6000, photo: 'home_picto/massage_assis.png', individual: true )
m2 = MassageCategory.create!(name: "Auto-massage (Do in)", price_cents: 18000, photo: 'home_picto/ateliers_do_in.png' )
m3 = MassageCategory.create!(name: "Yoga", price_cents: 18000, photo: 'home_picto/ateliers_yoga.png' )
m4 = MassageCategory.create!(name: "Sophrologie", price_cents: 18000, photo: 'home_picto/ateliers_sophrologie.png' )
m5 = MassageCategory.create!(name: "Méditation pleine conscience", price_cents: 18000, photo: 'home_picto/ateliers_meditation.png' )
m6 = MassageCategory.create!(name: "Pilate", price_cents: 18000, photo: 'home_picto/ateliers_pilat.png' )

puts 'Create Author'

a = BlogAuthor.create!(first_name: "Kwfinder", last_name: "Serped")

puts 'Create Tags'

t1 = BlogTag.create!(name: "bien-être au travail")
t2 = BlogTag.create!(name: "conditions de travail")
t3 = BlogTag.create!(name: "lutter contre le stress")
t4 = BlogTag.create!(name: "atelier collectif")


puts 'Create Articles'

url = "https://images.pexels.com/photos/1647916/pexels-photo-1647916.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
url2 = "https://images.pexels.com/photos/450271/pexels-photo-450271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
a1 = BlogArticle.new(title: "5 conseils pour améliorer le bien-être au travail", content: "Dans une société où la vie professionnelle occupe la majorité du temps, mettre en place
quelques astuces pour améliorer le bien-être au travail des salariés devient un enjeu grandissant
pour les entreprises françaises. Voici quelques conseils.", published_at: DateTime.now, author: a)
a1.remote_photo_url = url2
a1.save
a2 = BlogArticle.new(title: "Les avantages des ateliers collectifs de gestion du stress en entreprise", content: "Dans le cadre de la mise en place d’une démarche de QVT (qualité de vie au travail), les
ateliers collectifs de gestion du stress s’avèrent être une solution de choix pour favoriser le bien-
être des salariés et resserrer les liens entre les équipes.", published_at: DateTime.now, author: a)
a2.remote_photo_url = url
a2.save

puts 'Create Tag for Articles'

BlogArticleTag.create!(blog_article: a1, blog_tag: t1)
BlogArticleTag.create!(blog_article: a1, blog_tag: t2)
BlogArticleTag.create!(blog_article: a1, blog_tag: t3)
BlogArticleTag.create!(blog_article: a2, blog_tag: t3)
BlogArticleTag.create!(blog_article: a2, blog_tag: t4)


puts 'Create Meta'

BlogMetum.create!(title: "title", content: "5 conseils pour améliorer le bien-être au travail", blog_article: a1)
BlogMetum.create!(title: "title", content: "Dans une société où la vie professionnelle occupe la majorité du temps, mettre en place", blog_article: a2)
BlogMetum.create!(title: "description", content: "5 conseils pour améliorer le bien-être au travail", blog_article: a1)

puts 'Create Praticien'
require 'csv'

csv_options = { col_sep: ';', quote_char: "|", headers: :first_row }
csv_filepath = File.read(Rails.root.join('db', 'csv', 'final_list_praticiens.csv'))
csv_praticiens = CSV.parse(csv_filepath, csv_options)
praticiens = []

csv_praticiens.each do |row|
  genre = row['genre'] == "H" ? 0 : 1
  praticien = Praticien.new(gender: genre,
    user_attributes: {
                    last_name: row['last_name'],
                    first_name: row['first_name'],
                    email: row['email'],
                    phone: row['telephone'],
                    password: "zenest2018",
                    birthday: row['birthday'],
                    address: row['address'],
                    zipcode: row['zipcode'],
                    city: row['city'],
                    complement: row['complement']
                  }
    )
  if row['photo'] != ""
    praticien.remote_photo_url = row['photo']
  end
  praticien.save
  praticiens << praticien
  competencies = row['competency'].split('/')
  competencies.each do |competency|
    competency = Competency.new(praticien: praticien, massage_category: MassageCategory.find_by(name: competency))
    competency.save
  end
end

puts 'Create Company'
csv_filepath = File.read(Rails.root.join('db', 'csv', 'list_companies.csv'))
csv_companies = CSV.parse(csv_filepath, csv_options)
companies = []
csv_companies.each do |row|
  siret = row['siret'] if row['siret']
  company= Company.new(name: row['name'],
                       address: row['address'],
                       zipcode: row['zipcode'],
                       city: row['city'],
                       siret: row[''])
  if row['photo'] != ""
    company.remote_logo_url = row['photo']
  end
  company.save
  companies << company
end

puts 'Create admin'
Praticien.create!(user_attributes: {email: "admin@zenest.pro", password: "azerty", first_name: "Etienne", last_name: "Zenest", admin: true})

