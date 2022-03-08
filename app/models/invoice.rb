class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :status

  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}

  def total_invoice_revenue
    invoice_items.sum("(unit_price * quantity)")
  end

  def self.not_completed
    where(:invoices => {status: 1}).order(created_at: :asc)
  end

  def total_discounts_by_merchant(merchant_id)
    invoice_items.joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold AND bulk_discounts.merchant_id = ?", merchant_id)
    .select("invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity * bulk_discounts.percentage_discount)) AS discounted_revenue")
    .group("invoice_items.id")
    .sum(&:discounted_revenue)
  end

  def total_revenue_by_merchant(merchant_id)
    invoice_items
    .select("invoice_items.id, (invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .group("invoice_items.id")
    .joins(:item)
    .where("items.merchant_id = ?", merchant_id)
    .sum(&:revenue)
  end

  def total_discounts
    invoice_items.joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select("invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity * bulk_discounts.percentage_discount)) AS discounted_revenue")
    .group("invoice_items.id")
    .sum(&:discounted_revenue)
  end
end
