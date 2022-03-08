class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice
  has_many :transactions, through: :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :quantity
  validates_numericality_of :quantity, only_integer: true
  validates_presence_of :unit_price
  validates_numericality_of :unit_price
  validates_presence_of :status
  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  def find_bulk_discount
    bulk_discounts
    .where('quantity_threshold <= ?', quantity)
    .order('bulk_discounts.percentage_discount')
    .last
  end
end
