class Item < ApplicationRecord
  belongs_to :merchant
  has_many :bulk_discounts, through: :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
  validates_presence_of :status
  enum status: {"Disabled" => 0, "Enabled" => 1}

  def best_day
    invoices.joins(:invoice_items, :transactions)
            .where(transactions:{result: 1})
            .select("invoices.*, SUM( invoice_items.unit_price * invoice_items.quantity)  AS totalrevenue")
            .group("invoices.id")
            .order(totalrevenue: :desc)
            .first.created_at
  end
end
