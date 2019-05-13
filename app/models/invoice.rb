    # t.string :title
    # t.string :pdf
    # t.datetime :date
    # t.references :invoiceable, polymorphic: true
    # t.string :reference
    # t.monetize :amount

class Invoice < ApplicationRecord
  before_create :default_date
  belongs_to :invoiceable, polymorphic: true
  monetize :amount_cents

  mount_uploader :pdf, PdfUploader

  validates :title, presence: true
  validates :date, presence: true
  validates :reference, uniqueness: { scope: :invoiceable_id }
  validates :title, uniqueness: true
  validates :reference, uniqueness: true
  validates :pdf, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :filtered_by_invoiceable_company, -> (user) { where(invoiceable: user.actable.company) }
  scope :filtered_by_invoiceable, -> (user) { where(invoiceable: user.actable) }
  scope :ordered_by_date_desc, -> { order(date: :desc) }

  ransacker :by_company_name,formatter: proc { |value|
    company = Company.find(value.to_i)
    data = Invoice.select{|invoice| invoice.owner == company }.map(&:id)
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :by_praticien_last_name,formatter: proc { |value|
    praticien = Praticien.find(value.to_i)
    data = Invoice.select{|invoice| invoice.owner == praticien }.map(&:id)
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  def default_date
    DateTime.now if date.nil?
  end

  def owner
    type = self.invoiceable_type.capitalize.constantize
    type.find(self.invoiceable_id)
  end

end
