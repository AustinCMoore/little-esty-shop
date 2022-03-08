require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    it ".find_bulk_discount" do
      merchant_A = Merchant.create!(name: "Merchant A")
      merchant_B = Merchant.create!(name: "Merchant B")
      merchant_C = Merchant.create!(name: "Merchant C")

      item_A1 = merchant_A.items.create!(name: "A1", description: "Merchant A Item 1", unit_price: 10)
      item_B1 = merchant_B.items.create!(name: "B1", description: "Merchant B Item 1", unit_price: 20)
      item_B2 = merchant_B.items.create!(name: "B2", description: "Merchant B Item 2", unit_price: 30)
      item_C1 = merchant_C.items.create!(name: "C1", description: "Merchant C Item 1", unit_price: 10000000)

      discount_A1 = merchant_A.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 3)
      discount_B1 = merchant_B.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 20)
      discount_B2 = merchant_B.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 30)
      discount_C1 = merchant_C.bulk_discounts.create!(percentage_discount: 1, quantity_threshold: 1)
      discount_C2 = merchant_C.bulk_discounts.create!(percentage_discount: 0, quantity_threshold: 5)

      customer_A = Customer.create!(first_name: "Customer", last_name: "Alpha")

      invoice_A1 = customer_A.invoices.create!(status: "completed")

      #no discount applied, revenue = 99 (prove a discount can be zero)
      invoice_item_A1_A1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_A1.id, quantity: 1, unit_price: 99, status: "shipped")
      #discount B1 applied, revenue = 4000, discount = 800, expected = 3200 (prove the same invoice can apply different discounts for different items for the same merchant)
      invoice_item_A1_B1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_B1.id, quantity: 20, unit_price: 200, status: "shipped")
      #discount B2 applied, revenue = 9000, discount = 2700, expected = 6300 (prove the same invoice can apply different discounts for different items for the same merchant)
      invoice_item_A1_B2 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_B2.id, quantity: 30, unit_price: 300, status: "shipped")
      #discount C1 applied, revenue = 10000000, discount = 10000000, expected = 0 (prove the upper limit, also provides easy to prove max/min values)
      invoice_item_A1_C1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_C1.id, quantity: 1, unit_price: 10000000, status: "shipped")
      #invoice A1 total revenue = 9599

      expect(invoice_item_A1_A1.find_bulk_discount).to eq(nil)
      expect(invoice_item_A1_B1.find_bulk_discount).to eq(discount_B1)
      expect(invoice_item_A1_B2.find_bulk_discount).to eq(discount_B2)
      expect(invoice_item_A1_C1.find_bulk_discount).to eq(discount_C1)
    end
  end
end
