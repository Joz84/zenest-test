# Fields of the model
# t.bigint "company_id"
# t.integer "stripe_id"
# t.boolean "admin_company", default: false
# t.string "matricule"
# t.text "complement_infos"

class Employee < ApplicationRecord
  attr_accessor :employee_code
  has_one :user, as: :actable, dependent: :destroy

  has_many :attendees, dependent: :destroy
  has_many :events, through: :attendees

  belongs_to :company
  has_many :booking_restrictions, through: :company
  has_many :calendars, through: :company
  has_many :active_calendars,
           -> { where(active: true) },
           through: :company,
           source: :calendars
  has_many :active_calendar_days, through: :active_calendars, source: :calendar_days
  has_many :active_events, through: :active_calendar_days, source: :events
  has_many :active_massage_categories, through: :active_events, source: :massage_category


  accepts_nested_attributes_for :user, allow_destroy: true
  delegate_missing_to :user

  validate :validate_email_extension, if: :email_extension?
  validate :validate_employee_code

  scope :filtered_by_company, -> (user) { where(company: user.company) }
  validates :conditions_validation, inclusion: { in: [true] }


  ransacker :by_last_name,formatter: proc { |value|
    value
  } do |parent|
    parent.table[:id]
  end
  # def read_attribute(attr_name, *args, &block)
  #   if attribute_method?(attr_name.to_s)
  #     super(attr_name, *args)
  #   else
  #     self.user.read_attribute(attr_name, *args, &block)
  #   end
  # end

  # def attributes=(new_attributes)
  #   sub = new_attributes.select { |k,v| attribute_method?(k) }
  #   sup = new_attributes.select { |k,v| !attribute_method?(k) }
  #   super(sub)
  #   Employee.attributes = sup
  # end

  # def email
  #   user.email
  # end

  # def write_attribute(attr_name, value, *args, &block)
  #   if attribute_method?(attr_name.to_s)
  #     super(attr_name, *args)
  #   else
  #     user.send(:write_attribute, attr_name, value, *args, &block)
  #   end
  # end

  def create_stripe_customer
    customer = Stripe::Customer.create(
      email: email,
      description: user.name
    )
    update(stripe_id: customer.id)
  end

  def stripe_customer
    Stripe::Customer.retrieve(stripe_id)
  end

  def email_extension?
    company&.email_extension_active
  end

  def find_company(employee_code)
    Company.find_by company_code: employee_code
  end

  private

  def validate_employee_code
    if find_company(employee_code).nil?
      errors.add(:employee_code, I18n.t('not_valid'))
    end
  end


  def validate_email_extension
    extension = user.email.split('@').last
    email_validate = company.email_extensions.find_by name: extension
    if email_validate.nil?
      user.errors.add(:email, "non compatible avec l'entreprise")
    end
  end

  # private :write_attribute

  #  def attributes
  #   self.user.nil? ? super : self.user.attributes.merge(super)
  # end


  # def attribute_names
  #   self.user.nil? ? super : super | (self.user.attribute_names)
  # end

  # def attributes
  #   user.attributes.merge(super)
  # end
end
