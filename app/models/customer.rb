class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :first_name
  validates_presence_of :last_name

  def name
    first_name + " " + last_name
  end

  def self.top_five
    joins(:invoices => :transactions)
    .select("customers.*, count(transactions.id) as count_transactions_id")
    .where(:transactions => {result: 1})
    .group(:id)
    .order(count_transactions_id: :desc)
    .limit(5)
  end
end
