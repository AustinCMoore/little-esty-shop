class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: ["cancelled": 0, "in progress": 1, completed: 2]

  def total_revenue
    self.invoice_items.sum(:unit_price)
  end
end
