class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :percentage_discount
  validates :percentage_discount, numericality: {
                                                  greater_than_or_equal_to: 0,
                                                  less_than_or_equal_to: 1
                                                }
  validates_presence_of :quantity_threshold
  validates_numericality_of :quantity_threshold, only_integer: true

end
