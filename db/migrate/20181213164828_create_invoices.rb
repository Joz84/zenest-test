class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :title
      t.string :pdf
      t.datetime :date
      t.references :invoiceable, polymorphic: true
      t.string :reference
      t.monetize :amount

      t.timestamps
    end
  end
end
