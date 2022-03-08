class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items

  validates_presence_of :percentage_discount
  validates_presence_of :quantity_threshold
end
