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
m1 = MassageCategory.create!(name: "Massage Assis", price_cents: 6000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081906/massage_assis.png', individual: true )
m2 = MassageCategory.create!(name: "Auto-massage (Do in)", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_do_in.png' )
m3 = MassageCategory.create!(name: "Yoga", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_yoga.png' )
m4 = MassageCategory.create!(name: "Sophrologie", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_sophrologie.png' )
m5 = MassageCategory.create!(name: "Méditation pleine conscience", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_meditation.png' )
m6 = MassageCategory.create!(name: "Pilate", price_cents: 18000, remote_photo_url: 'https://res-console.cloudinary.com/kentlay/thumbnails/v1/image/upload/v1553629447/YXRlbGllcnNfcGlsYXQ=/preview' )

puts 'Create Author'

a = BlogAuthor.create!(first_name: "Kwfinder", last_name: "Serped")

puts 'Create Tags'

t1 = BlogTag.create!(name: "bien-être au travail")
t2 = BlogTag.create!(name: "conditions de travail")
t3 = BlogTag.create!(name: "lutter contre le stress")
t4 = BlogTag.create!(name: "atelier collectif")


puts 'Create Articles'

url = "https://images.pexels.com/photos/716276/pexels-photo-716276.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
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


# # Employee to use as test coco@gmail.com azerty
# # Praticien to use as test annickferreira78@gmail.com     zenest2018
# puts 'Create Massage Category'
# # La création des massages categories doit être faite en 1er
# m1 = MassageCategory.create!(name: "Massage Assis", price_cents: 6000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081906/massage_assis.png', individual: true )
# m2 = MassageCategory.create!(name: "DO In", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_do_in.png' )
# m3 = MassageCategory.create!(name: "Yoga", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_yoga.png')
# m4 = MassageCategory.create!(name: "Sophrologie", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_sophrologie.png' )
# m5 = MassageCategory.create!(name: "Meditation Pleine Conscience", price_cents: 18000, remote_photo_url: 'https://res.cloudinary.com/www-zenest-pro/image/upload/v1548081965/ateliers_meditation.png' )

# puts 'Create Company'
# c = Company.create!(name: "Bon Marché", address: "5 rue de Babylone", zipcode: "75007", city: "Paris", company_code: 'B23456')
# c.update(remote_logo_url: "http://www.hotels-paris-rive-gauche.com/blog/wp-content/uploads/2017/03/Le-Bon-Marche-logo.jpg")
# c1 = Company.create!(name: "Lanvin", address: "14 rue Boissy d’Anglas", zipcode: "75008", city: "Paris", company_code: '1234B6')
# c1.update(remote_logo_url: "https://seeklogo.com/images/L/lanvin-logo-84F638F33C-seeklogo.com.png")
# c2 = Company.create!(name: "Ubisoft", address: "126 rue de Lagny", zipcode: "93100", city: "Montreuil", company_code: '000000')
# c2.update(remote_logo_url: "https://media.begeek.fr/2018/07/Ubisoft-jeux-fins-660x371.jpg")
# c3 = Company.create!(name: "Orepa Résidence Le Corbusier", address: "61/65 rue de Bellevue", zipcode: "92100", city: "Boulogne-Billancourt", company_code: '000001')
# c3.update(remote_logo_url: "https://www.revente-ehpad-occasion.fr/uploads/actors/13/pictures/49/show.png?1505117876")
# c4 = Company.create!(name: "Orange ", address: "1 avenue Nelson Mandela", zipcode: "94110", city: "Arceuil", company_code: '000002')
# c4.update(remote_logo_url: "http://lafayetteassocies.com/wp-content/uploads/2018/06/Orange-logo.png")

# puts 'Create Employee'
# e = Employee.create!(company: c, employee_code: c.company_code, admin_company: true, conditions_validation: true, user_attributes: {email: "corine.noity@bonmarche.com", password: "azerty", first_name: "Corine", last_name: "Noity"})
# e2 = Employee.create!(company: c, employee_code: c.company_code, conditions_validation: true, user_attributes: {email: "tom.dupuis@bonmarche.com", password: "azerty", first_name: "Tom", last_name: "Dupuis"})
# e3 = Employee.create!(company: c, employee_code: c.company_code, conditions_validation: true, user_attributes: {email: "theo.smith@bonmarche.com", password: "azerty", first_name: "Théo", last_name: "Smith"})
# e4 = Employee.create!(company: c2, employee_code: c2.company_code, conditions_validation: true, user_attributes: {email: "lulu@gmail.com", password: "azerty", first_name: "Ludovic", last_name: "Poty"})
# e5 = Employee.create!(company: c3, employee_code: c2.company_code, conditions_validation: true, user_attributes: {email: "lili@gmail.com", password: "azerty", first_name: "Lili", last_name: "Thuio"})
# e6 = Employee.create!(company: c3, employee_code: c3.company_code, conditions_validation: true, user_attributes: {email: "huhu@gmail.com", password: "azerty", first_name: "Hubert", last_name: "Luit"})
# e7 = Employee.create!(company: c4, employee_code: c3.company_code, conditions_validation: true, user_attributes: {email: "yuyu@gmail.com", password: "azerty", first_name: "Yolande", last_name: "Pred"})




# puts 'Create Praticiens'

# require 'csv'

# csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
# csv_filepath = File.read(Rails.root.join('db', 'csv', 'list_praticiens.csv'))
# csv_praticiens = CSV.parse(csv_filepath, csv_options)

# random_pictures = ["https://images.pexels.com/photos/997750/pexels-photo-997750.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
#   "https://images.pexels.com/photos/1121796/pexels-photo-1121796.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
#   "https://images.pexels.com/photos/1036622/pexels-photo-1036622.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
# "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
# "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
# "https://images.pexels.com/photos/1065084/pexels-photo-1065084.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
# "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"]

# praticiens = []

# csv_praticiens.each do |row|
#   genre = row['genre']== "H" ? 0 : 1
#   last_name = row['name'] || row['email'][0..5]
#   first_name = row['name'] || row['email'][6..9]
#   praticien = Praticien.new(gender: genre,
#     user_attributes: {
#                     last_name: last_name,
#                     first_name: first_name,
#                     email: row['email'],
#                     phone: row['telephone'],
#                     password: "zenest2018"}
#     )
#   praticien.remote_photo_url = random_pictures.sample
#   praticien.save
#   praticiens << praticien
# end
# #Create Admin login

# puts 'Create Admin'
# #User.create(email: "admin@zenest.pro", password: "azerty", first_name: "Etienne", last_name: "Zenest", admin: true)
# Praticien.create!(user_attributes: {email: "admin@zenest.pro", password: "azerty", first_name: "Etienne", last_name: "Zenest", admin: true})


# puts 'Create Author'

# a = BlogAuthor.create!(first_name: "Kwfinder", last_name: "Serped")

# puts 'Create Tags'

# t1 = BlogTag.create!(name: "bien-être au travail")
# t2 = BlogTag.create!(name: "conditions de travail")
# t3 = BlogTag.create!(name: "lutter contre le stress")
# t4 = BlogTag.create!(name: "atelier collectif")


# puts 'Create Articles'

# url = "https://images.pexels.com/photos/716276/pexels-photo-716276.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
# url2 = "https://images.pexels.com/photos/450271/pexels-photo-450271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
# a1 = BlogArticle.new(title: "5 conseils pour améliorer le bien-être au travail", content: "Dans une société où la vie professionnelle occupe la majorité du temps, mettre en place
# quelques astuces pour améliorer le bien-être au travail des salariés devient un enjeu grandissant
# pour les entreprises françaises. Voici quelques conseils.", published_at: DateTime.now, author: a)
# a1.remote_photo_url = url2
# a1.save
# a2 = BlogArticle.new(title: "Les avantages des ateliers collectifs de gestion du stress en entreprise", content: "Dans le cadre de la mise en place d’une démarche de QVT (qualité de vie au travail), les
# ateliers collectifs de gestion du stress s’avèrent être une solution de choix pour favoriser le bien-
# être des salariés et resserrer les liens entre les équipes.", published_at: DateTime.now, author: a)
# a2.remote_photo_url = url
# a2.save

# puts 'Create Tag for Articles'

# BlogArticleTag.create!(blog_article: a1, blog_tag: t1)
# BlogArticleTag.create!(blog_article: a1, blog_tag: t2)
# BlogArticleTag.create!(blog_article: a1, blog_tag: t3)
# BlogArticleTag.create!(blog_article: a2, blog_tag: t3)
# BlogArticleTag.create!(blog_article: a2, blog_tag: t4)


# puts 'Create Meta'

# BlogMetum.create!(title: "title", content: "5 conseils pour améliorer le bien-être au travail", blog_article: a1)
# BlogMetum.create!(title: "title", content: "Dans une société où la vie professionnelle occupe la majorité du temps, mettre en place", blog_article: a2)
# BlogMetum.create!(title: "description", content: "5 conseils pour améliorer le bien-être au travail", blog_article: a1)

# puts 'Create Calendar'
# companies = [c, c2, c3, c4]
# companies.each {|company| company.calendars.create!(name: "Calendrier 2018", active: true)}
# companies.each {|company| company.calendars.create!(name: "Calendrier 2019", active: true)}

# puts 'Create Calendar day'
# Calendar.all.each do |calendar|
#   days = [DateTime.now, (DateTime.now) - 1, (DateTime.now) + 4, (DateTime.now) + 2, (DateTime.now) + 6 ]
#   days.each do |day|
#     c_day = calendar.calendar_days.create!(date: day.to_date)
#     # mcs = c_day.massage_categories
#     # mcs.each do |mc|
#     #   c_day.requirements.create!(massage_category: mc, nb_praticiens: [1,2,3,4].sample)
#     # end
#   end
# end

# puts 'Create Event'
# massages = [m1, m2, m3, m4, m5]
# praticien_specific = User.find_by(email: "annickferreira78@zenest.pro").actable

# companies.each do |company|
#   company_calendar_days = company.calendar_days
#   calendar_day = company_calendar_days.sample

#   ev1 = Event.new(start_date: calendar_day.date + 8.hours ,
#                   end_date: calendar_day.date + 8.hours + 15.minutes,
#                   massage_category: m1,
#                   calendar_day: calendar_day,
#                   praticien: praticiens.sample,
#                   max_attendees: 8,
#                   min_attendees: 1)
#   ev1.title = ev1.massage_category.name + "1"
#   ev1.save
#   ev2 = Event.new(start_date: calendar_day.date + 8.hours + 60.minutes ,
#                   end_date: calendar_day.date + 8.hours + 120.minutes,
#                   massage_category: m2,
#                   calendar_day: calendar_day,
#                   praticien: praticiens.sample,
#                   max_attendees: 8,
#                   min_attendees: 1)
#   ev2.title = ev2.massage_category.name + "2"
#   ev2.save
#   ev3 = Event.new(start_date: calendar_day.date + 8.hours ,
#                   end_date: calendar_day.date + 8.hours + 60.minutes,
#                   massage_category: m2,
#                   calendar_day: calendar_day,
#                   praticien: praticiens.sample,
#                   max_attendees: 8,
#                   min_attendees: 1)
#   ev3.title = ev3.massage_category.name + "3"
#   ev3.save

#   calendar_day2 = company_calendar_days.sample
#   ev4 = Event.new(start_date: calendar_day2.date + 8.hours,
#                   end_date: calendar_day2.date + 8.hours + 15.minutes,
#                   massage_category: m1,
#                   calendar_day: calendar_day2,
#                   praticien: praticiens.sample,
#                   max_attendees: 8,
#                   min_attendees: 1)
#   ev4.title = ev4.massage_category.name + "4"
#   ev4.save

#   ev5 = Event.new(start_date: calendar_day2.date + 10.hours + 60.minutes,
#                   end_date: calendar_day2.date + 10.hours + 120.minutes,
#                   massage_category: m2,
#                   calendar_day: calendar_day2,
#                   praticien: praticien_specific,
#                   max_attendees: 8,
#                   min_attendees: 1)
#   ev5.title = ev5.massage_category.name + "5"
#   ev5.save

# end

# puts 'Events created = #{Event.all.size}'

# puts 'Create Attendees'
# Event.all.each do |event|
#   company = event.company
#   Attendee.create!(event: event, employee: Employee.where(company: company).sample, status: 0)
# end


# puts "Create Employee with multiples attendees"
# employee = User.find_by(email: "corine.noity@bonmarche.com").actable

# 5.times do
#   company_calendar_days = employee.company.calendar_days
#   calendar_day = company_calendar_days.sample
#   events = Event.all.select { |ev| ev.company == employee.company }
#   events.each do |ev|
#     Attendee.create!(event: ev, employee: employee, status: 0) if Attendee.where(employee: employee).where(event: ev).empty?
#   end
# end

# # invoice = employee.company.invoices.new(title: 'Facture de Janvier 2019', amount: 1200, reference: "F34567",date: DateTime.now)
# # invoice.remote_pdf_url = "https://res.cloudinary.com/www-zenest-pro/image/upload/v1549441095/InvoiceF34567.pdf"
# # invoice.save!
# puts "Create Praticien events"
# praticien = User.find_by(email: "annickferreira78@zenest.pro").actable

# # 10.times do
# #   calendar_day = CalendarDay.all.sample
# #   massage = massages.sample
# #   duration = massage == m1 ? calendar_day.date + 15.minutes : calendar_day.date + 60.minutes
# #   ev = Event.new(start_date: calendar_day.date ,
# #                   end_date: duration,
# #                   massage_category: massage,
# #                   calendar_day: calendar_day,
# #                   praticien: praticien,
# #                   max_attendees: 8,
# #                   min_attendees: 1)
# #   ev.title = ev.massage_category.name
# #   ev.save
# # end

# puts 'Création event cohérent'
# calendar = Event.first.calendar
# date = DateTime.now.to_date + 6.days
# calendar_day = calendar.calendar_days.find_by(date: date)
# m1 = MassageCategory.find_by(name: "Massage Assis")
# praticiens = Praticien.all.includes(:user).where.not(users: {email: "admin@zenest.pro"})

#   ev1 = Event.new(start_date: calendar_day.date + 8.hours ,end_date: calendar_day.date + 8.hours + 15.minutes,massage_category: m1,calendar_day: calendar_day,praticien: praticiens.sample,max_attendees: 1,min_attendees: 1)
#   ev1.title = ev1.massage_category.name + "9"
#   ev1.save

#   ev2 = Event.new(start_date: calendar_day.date + 8.hours , end_date: calendar_day.date + 8.hours + 15.minutes, massage_category: m1, calendar_day: calendar_day, praticien: praticiens.sample, max_attendees: 1, min_attendees: 1)
#   ev2.title = ev2.massage_category.name + "10"
#   ev2.save

#  ev3 = Event.new(start_date: calendar_day.date + 8.hours + 15.minutes, end_date: calendar_day.date + 8.hours + 30.minutes, massage_category: m1, calendar_day: calendar_day, praticien: praticiens.sample, max_attendees: 1, min_attendees: 1)
#   ev3.title = ev3.massage_category.name + "11"
#   ev3.save

#   ev4 = Event.new(start_date: calendar_day.date + 8.hours + 15.minutes, end_date: calendar_day.date + 8.hours + 30.minutes, massage_category: m1, calendar_day: calendar_day, praticien: praticiens.sample, max_attendees: 1, min_attendees: 1)
#   ev4.title = ev4.massage_category.name + "12"
#   ev4.save

#   ev5 = Event.new(start_date: calendar_day.date + 8.hours + 15.minutes, end_date: calendar_day.date + 8.hours + 30.minutes, massage_category: m1, calendar_day: calendar_day, praticien: praticiens.sample, max_attendees: 1, min_attendees: 1)
#   ev5.title = ev5.massage_category.name + "13"
#   ev5.save

# puts "Create Praticien Requirements & Availability"

# r = Requirement.create(calendar_day: Event.last.calendar_day, massage_category: Event.last.massage_category, nb_praticiens: 2, amount: 234)
# Availability.create(requirement: r, praticien: praticien)
