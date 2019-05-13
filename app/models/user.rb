# Fields of the model
 # :first_name, :string
 # :last_name, :string
 # :birthday, :datetime
 # :address, :string
 # :zipcode, :string
 # :city, :string
 # :phone, :string
 # :complement, :string
 # :photo, :string
 # :type, :string
 # :active, :boolean, default: true
 # :stripe_id, :integer
 # :available, :boolean, default: true
 # :users, :company, index: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:confirmable

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :actable, polymorphic: true

  scope :employees, -> { where(actable_type: "Employee") }
  scope :admin_companies, -> { where(actable_type: "Employee").where(admin_company: true) }
  scope :praticiens, -> { where(actable_type: "Praticien") }

  def employee?
    self.actable_type == "Employee"
  end

  def praticien?
    self.actable_type == "Praticien"
  end

  def admin_employee?
    employee? && actable.admin_company
  end

  def company
    self.actable.company if employee?
  end

  def name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.ransaker_filter_by_and_ordered_by(type, attribute)
    filter_by(type)
    .ordered_by(attribute)
    .ransaker_filter_format(attribute)
  end

  private

  def self.filter_by(type)
    where(actable_type: type)
  end

  def self.ordered_by(attribute)
    select(attribute, :actable_id)
    .order(attribute => :asc)
  end

  def self.ransaker_filter_format(attribute)
    all.map{|user| [user[attribute], user.actable_id]}
  end

end
