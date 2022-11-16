class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [ :"in progress", :cancelled, :completed ]

  def invoice_item(item_id)
    invoice_items.find_by(item_id: item_id)
  end

  def total_revenue(merchant_id)
    invoice_items
    .joins(:item)
    .where("items.merchant_id = ?", merchant_id)
    .sum("quantity * invoice_items.unit_price")
  end

  def admin_total_revenue
    invoice_items
    .joins(:item)
    .sum("quantity * invoice_items.unit_price")
  end

  def discount_amount(merchant_id)
    invoice_items
    .joins(:bulk_discounts, :item)
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .where('items.merchant_id = ?', merchant_id)
    .select('invoice_items.item_id, max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount * 0.01)')
    .group('invoice_items.item_id')
    .sum(&:max)
  end

  def revenue_after_discount(merchant_id)
    total_revenue(merchant_id) - discount_amount(merchant_id)
  end
end
