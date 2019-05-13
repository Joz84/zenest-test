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

class Company < ApplicationRecord
  after_create :creation_booking_restrictions
  before_create :create_company_code

  has_many :employees, source: :actable, source_type: 'Employee', class_name: 'Employee', dependent: :destroy
  has_many :invoices, as: :invoiceable, dependent: :destroy
  has_many :email_extensions, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :calendar_days, through: :calendars
  has_many :events, through: :calendar_days
  has_many :booking_restrictions, dependent: :destroy

  mount_uploader :logo, PhotoUploader

  scope :filter_by_logo, -> { where.not(logo: nil) }

  validates :name, presence: true

  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :invoices, allow_destroy: true
  accepts_nested_attributes_for :calendars, allow_destroy: true
  accepts_nested_attributes_for :email_extensions, allow_destroy: true
  accepts_nested_attributes_for :booking_restrictions

  def self.ransaker_ordered_by(attribute)
    all.order(attribute => :asc)
    .map{|company| [company[attribute], company.id]}
  end

  def self.company_codes
    all.select(:company_code).map(&:company_code)
  end

  def admin
    Employee.where(company: self).where(admin_company: true).first
  end

  def photo
    logo
  end

  def full_address
    "#{address}, #{zipcode} #{city}"
  end


  def self.ransaker_ordered_by(attribute)
    all.order(attribute => :asc)
    .map{|company| [company[attribute], company.id]}
  end

  private

  def create_company_code
    letters = ('A'..'Z').to_a
    numbers = ('0'..'9').to_a
    code = letters.sample + numbers.sample(5).join
    while Company.find_by company_code: code
      code = letters.sample + numbers.sample(5).join
    end
    self.company_code = code
  end
  def creation_booking_restrictions
    MassageCategory.all.each do |massage_category|
      BookingRestriction.create!(massage_category: massage_category, company: self, rate: 100000)
    end
  end
end
