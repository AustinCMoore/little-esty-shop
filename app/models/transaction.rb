class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :credit_card_number
  validates_presence_of :result

  enum result: {"failed" => 0, "success" => 1 }
end
