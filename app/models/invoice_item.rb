class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_many :bulk_discounts, through: :item

  enum status: [ :pending, :packaged, :shipped ]

  def self.not_shipped
    self.where.not(status: 2)
  end

  def self.sort_by_invoice_creation_date
    joins(:invoice).order('invoices.created_at')
  end
end
