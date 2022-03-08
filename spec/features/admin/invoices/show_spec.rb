require 'rails_helper'

RSpec.describe 'the admin invoice show' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending")
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped")
  end

  it "Invoice Information in show page" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer_1.first_name}")
    expect(page).to have_content("#{@customer_1.last_name}")
  end

  it "Shows Invoice Items with item details" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("#{@item_1.name}")
    expect(page).to have_content("#{@item_2.name}")
    expect(page).to have_content("#{@invoice_item_1.quantity}")
    expect(page).to have_content("#{@invoice_item_2.quantity}")
    expect(page).to have_content("#{@invoice_item_1.unit_price}")
    expect(page).to have_content("#{@invoice_item_2.unit_price}")
    expect(page).to have_content("#{@invoice_item_1.status}")
    expect(page).to have_content("#{@invoice_item_2.status}")
  end

  it "Total Revenue will be shown for each Invoice" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content(71)
  end

  it "can change an invoice status" do
    visit "/admin/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Invoice Status: completed")
    expect(page).to_not have_content("Invoice Status: cancelled")
    expect(page).to_not have_content("Invoice Status: in progress")

    choose("cancelled")
    click_on("Update Invoice Status")

    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")

    expect(page).to_not have_content("Invoice Status: completed")
    expect(page).to have_content("Invoice Status: cancelled")
    expect(page).to_not have_content("Invoice Status: in progress")
  end
end

describe "final project" do #marks solo work
  it "has a total revenue and discounted revenue for each invoice" do
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
    customer_B = Customer.create!(first_name: "Customer", last_name: "Beta")

    invoice_A1 = customer_A.invoices.create!(status: "completed")
    invoice_B1 = customer_B.invoices.create!(status: "completed")
    invoice_A2 = customer_A.invoices.create!(status: "completed")

    #Should be equal to invoice A1
    #no discount applied, revenue = 99 (prove a discount can be zero)
    invoice_item_B1_A1 = InvoiceItem.create!(invoice_id: invoice_B1.id, item_id: item_A1.id, quantity: 1, unit_price: 99, status: "shipped")
    #discount B1 applied, revenue = 4000, discount = 800, expected = 3200 (prove the same invoice can apply different discounts for different items for the same merchant)
    invoice_item_B1_B1 = InvoiceItem.create!(invoice_id: invoice_B1.id, item_id: item_B1.id, quantity: 20, unit_price: 200, status: "shipped")
    #discount B2 applied, revenue = 9000, discount = 2700, expected = 6300 (prove the same invoice can apply different discounts for different items for the same merchant)
    invoice_item_B1_B2 = InvoiceItem.create!(invoice_id: invoice_B1.id, item_id: item_B2.id, quantity: 30, unit_price: 300, status: "shipped")
    #discount C1 applied, revenue = 10000000, discount = 10000000, expected = 0 (prove the upper limit, also provides easy to prove max/min values)
    invoice_item_B1_C1 = InvoiceItem.create!(invoice_id: invoice_B1.id, item_id: item_C1.id, quantity: 1, unit_price: 10000000, status: "shipped")
    #invoice B1 total revenue = 9599

    #no discount applied, revenue = 99 (prove a discount can be zero)
    invoice_item_A1_A1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_A1.id, quantity: 1, unit_price: 99, status: "shipped")
    #discount B1 applied, revenue = 4000, discount = 800, expected = 3200 (prove the same invoice can apply different discounts for different items for the same merchant)
    invoice_item_A1_B1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_B1.id, quantity: 20, unit_price: 200, status: "shipped")
    #discount B2 applied, revenue = 9000, discount = 2700, expected = 6300 (prove the same invoice can apply different discounts for different items for the same merchant)
    invoice_item_A1_B2 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_B2.id, quantity: 30, unit_price: 300, status: "shipped")
    #discount C1 applied, revenue = 10000000, discount = 10000000, expected = 0 (prove the upper limit, also provides easy to prove max/min values)
    invoice_item_A1_C1 = InvoiceItem.create!(invoice_id: invoice_A1.id, item_id: item_C1.id, quantity: 1, unit_price: 10000000, status: "shipped")
    #invoice A1 total revenue = 9599

    #discount A1 applied, revenue = 297, discount = 29.7, expected = 267.3 (prove a discount that was zero can be triggered, but also give float value. From lecture, we do not need to test rounding up or down on a fraction of a penny)
    invoice_item_A2_A1 = InvoiceItem.create!(invoice_id: invoice_A2.id, item_id: item_A1.id, quantity: 3, unit_price: 99, status: "shipped")
    #no discount applied, revenue = 3800 (prove upper cutoff for a discount)
    invoice_item_A2_B1 = InvoiceItem.create!(invoice_id: invoice_A2.id, item_id: item_B1.id, quantity: 19, unit_price: 200, status: "shipped")
    # discount B1 applied, revenue = 6300, discount = 1260, expected = 5040 (prove greater than a threshold will trigger a discount)
    invoice_item_A2_B2 = InvoiceItem.create!(invoice_id: invoice_A2.id, item_id: item_B2.id, quantity: 21, unit_price: 300, status: "shipped")
    #discount C1 applied, revenue = 10000000, discount = 10000000, expected = 0 (prove C1 always overwrites C2, provide easy to identify min/max values)
    invoice_item_A2_C1 = InvoiceItem.create!(invoice_id: invoice_A2.id, item_id: item_C1.id, quantity: 10, unit_price: 10000000, status: "shipped")
    #invoice A2 total revenue = 9107.3 (should round to either 91.07 or 91.08)

    visit "/admin/invoices/#{invoice_B1.id}"

    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $100,130.99")
    end

    within ".revenue-discounted" do
      expect(page).to have_content("Total Revenue after Discounts: $95.99")
    end

    visit "/admin/invoices/#{invoice_A1.id}"

    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $100,130.99")
    end

    within ".revenue-discounted" do
      expect(page).to have_content("Total Revenue after Discounts: $95.99")
    end

    visit "/admin/invoices/#{invoice_A2.id}"

    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $1,000,103.97")
    end

    within ".revenue-discounted" do
      expect(page).to have_content("Total Revenue after Discounts: $91.07")
    end
  end
end
