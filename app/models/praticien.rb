# Fields of the model
# :photo

class Praticien < ApplicationRecord
  has_one :user, as: :actable, dependent: :destroy
  has_many :invoices, as: :invoiceable
  has_many :competencies
  has_many :massage_categories, through: :competencies
  has_many :availabilities
  has_many :requirements, through: :availabilities
  has_many :events

  mount_uploader :photo, PhotoUploader
  enum gender: { men: 0, women: 1 }

  scope :filter_by_photo, -> { where.not(photo: nil) }
  scope :filtered_by_available_availabilities, -> { includes(:availabilities).where(availabilities: {status: 1})}
  scope :filtered_by_requirements, -> (event) { includes(:requirements).where(requirements: {massage_category: event.massage_category, calendar_day: event.calendar_day})}
  scope :filtered_by_requirement, -> (requirement) { includes(:requirements).where(requirements: {massage_category: requirement.massage_category, calendar_day: requirement.calendar_day})}
  scope :filtered_by_competency, -> (massage_category) { includes(:competencies).where(competencies: {massage_category: massage_category})}
  accepts_nested_attributes_for :user, allow_destroy: true
  accepts_nested_attributes_for :competencies, allow_destroy: true
  accepts_nested_attributes_for :massage_categories, allow_destroy: true
  delegate_missing_to :user

  PRATICIEN_EMAILS_FOR_HOMEPAGE = [
    'celinemigeon@gmail.com',
    'charpentier.julien.91@gmail.com',
    'lamargo@free.fr',
    'sabri.manoubi@naturopraticien.com',
    'helene.salama@gmail.com',
    'christophe@bienetrerelaxation.com',
    'contact.abrisard@gmail.com',
    'neoshiatsu@gmail.com',
    'caroc43@hotmail.com',
    'phgaudin@neuf.fr',
    'lara.barontini@orange.fr',
    'rodriguebilard@gmail.com',
    'graine2vie@gmail.com',
    'david.bensoussan@gmail.com',
    'contact@feelyin.com',
    'eric_affergan@hotmail.com',
    'anne.kalache@gmail.com',
    'contactdetendezvous@gmail.com',
    'odetebmiranda@hotmail.fr',
    'bertrand@beingwell.fr',
    'cantauralacruz@gmail.com',
    'falvarez-sanchez@wanadoo.fr',
    'revitaletsens@orange.fr',
    'andaluzen@gmail.com'
  ]

  ransacker :by_last_name,formatter: proc { |value|
    value
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_first_name,formatter: proc { |value|
    value
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_city,formatter: proc { |value|
    value
  } do |parent|
    parent.table[:id]
  end

  def self.select_by_emails(emails)
    praticiens = Praticien.where.not(photo: nil).includes(:user).where(users: {email: emails}).map{ |praticien| [praticien.user.email, praticien.id]}.to_h
    ids  = emails.map{|email| praticiens[email]}
    Praticien.find(ids)
  end

  def has_photo?
    photo.url.nil?
  end

  def default_photo_url
    photo.url || PICTO_PRATCIEN_URL
  end

end
