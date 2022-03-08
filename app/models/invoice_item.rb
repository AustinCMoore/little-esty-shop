class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  def find_bulk_discount
    bulk_discounts
    .where('quantity_threshold <= ?', quantity)
    .order('bulk_discounts.percentage_discount')
    .last
  end
end
