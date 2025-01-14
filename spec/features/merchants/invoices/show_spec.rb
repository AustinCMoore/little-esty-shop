require 'rails_helper'

RSpec.describe "Merchant Invoices Show Page" do
  before (:each) do
    @merchant_1 = Merchant.create!(name: "Staples")

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    @customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    @customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    @customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    @customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")
    @invoice_5 = @customer_2.invoices.create!(status: "cancelled")
    @invoice_6 = @customer_3.invoices.create!(status: "in progress")
    @invoice_7  = @customer_3.invoices.create!(status: "completed")
    @invoice_8 = @customer_3.invoices.create!(status: "cancelled")
    @invoice_9 = @customer_4.invoices.create!(status: "in progress")
    @invoice_10 = @customer_4.invoices.create!(status: "completed")
    @invoice_11 = @customer_5.invoices.create!(status: "cancelled")
    @invoice_12 = @customer_6.invoices.create!(status: "in progress")

    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending")
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped")
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 5, unit_price: 13, status: "packaged")
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_2.id, quantity: 6, unit_price: 29, status: "pending")
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_3.id, quantity: 1, unit_price: 84, status: "shipped")
    @invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_4.id, quantity: 2, unit_price: 25, status: "packaged")
    @invoice_item_9 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_1.id, quantity: 3, unit_price: 13, status: "pending")
    @invoice_item_10 = InvoiceItem.create!(invoice_id: @invoice_10.id, item_id: @item_2.id, quantity: 4, unit_price: 29, status: "shipped")
    @invoice_item_11 = InvoiceItem.create!(invoice_id: @invoice_11.id, item_id: @item_3.id, quantity: 5, unit_price: 84, status: "packaged")
    @invoice_item_12 = InvoiceItem.create!(invoice_id: @invoice_12.id, item_id: @item_4.id, quantity: 6, unit_price: 25, status: "pending")

    @transcation_1 = @invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    @transcation_2 = @invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    @transcation_3 = @invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    @transcation_4 = @invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    @transcation_5 = @invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "success")
    @transcation_6 = @invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    @transcation_7 = @invoice_7.transactions.create!(credit_card_number: "4654405418249639", result: "success")
    @transcation_8 = @invoice_8.transactions.create!(credit_card_number: "4654405418249630", result: "success")
    @transcation_9 = @invoice_9.transactions.create!(credit_card_number: "4654405418249612", result: "success")
    @transcation_10 = @invoice_10.transactions.create!(credit_card_number: "4654405418249613", result: "success")
    @transcation_11 = @invoice_11.transactions.create!(credit_card_number: "4654405418249614", result: "success")
    @transcation_12 = @invoice_12.transactions.create!(credit_card_number: "4654405418249635", result: "failed")
  end

  it "displays the invoice id, status, when it was created and customer name" do
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
  end

  it "displays all the invoice items names, qty, price, and shipping status" do
    @invoice_item_13 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 29, status: "shipped")

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Item name: #{@item_1.name}")
    expect(page).to have_content("Item name: #{@item_2.name}")
    expect(page).to_not have_content("Item name: #{@item_3.name}")

    expect(page).to have_content("Qty: #{@invoice_item_1.quantity}")
    expect(page).to have_content("Qty: #{@invoice_item_13.quantity}")
    expect(page).to_not have_content("Qty: #{@invoice_item_3.quantity}")

    expect(page).to have_content("Unit price: #{@item_1.unit_price}")
    expect(page).to have_content("Unit price: #{@item_2.unit_price}")

    expect(page).to have_content("Status: #{@invoice_item_1.status}")
    expect(page).to have_content("Status: #{@invoice_item_13.status}")
  end

  it "displays total revenue" do
    @invoice_item_13 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 29, status: "shipped")

    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Total Revenue: $0.42")
  end

  it "can change an item's status" do
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Status: shipped")
    expect(page).to_not have_content("Status: packaged")

    choose('packaged')
    click_on('Update Item Status')

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

    expect(page).to_not have_content("Status: shipped")
    expect(page).to have_content("Status: packaged")
  end
end

describe "final project" do #marks solo work
  it "has a total revenue and discounted revenue for each merchant's cut of an invoice" do
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

    visit "/merchants/#{merchant_A.id}/invoices/#{invoice_B1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $0.99")
      expect(page).to have_content("Total Revenue after Discounts: $0.99")
    end

    visit "/merchants/#{merchant_B.id}/invoices/#{invoice_B1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $130.00")
      expect(page).to have_content("Total Revenue after Discounts: $95.00")
    end

    visit "/merchants/#{merchant_C.id}/invoices/#{invoice_B1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $100,000.0")
      expect(page).to have_content("Total Revenue after Discounts: $0.00")
    end

    visit "/merchants/#{merchant_A.id}/invoices/#{invoice_A1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $0.99")
      expect(page).to have_content("Total Revenue after Discounts: $0.99")
    end

    visit "/merchants/#{merchant_A.id}/invoices/#{invoice_A2.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $2.97")
      expect(page).to have_content("Total Revenue after Discounts: $2.67") #267 or 268 if rounded up
    end

    visit "/merchants/#{merchant_B.id}/invoices/#{invoice_A1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $130.00")
      expect(page).to have_content("Total Revenue after Discounts: $95.00")
    end

    visit "/merchants/#{merchant_B.id}/invoices/#{invoice_A2.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $101.00")
      expect(page).to have_content("Total Revenue after Discounts: $88.40")
    end

    visit "/merchants/#{merchant_C.id}/invoices/#{invoice_A1.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $100,000.00")
      expect(page).to have_content("Total Revenue after Discounts: $0.00")
    end

    visit "/merchants/#{merchant_C.id}/invoices/#{invoice_A2.id}"
    within ".revenue-totals" do
      expect(page).to have_content("Total Revenue: $1,000,000.00")
      expect(page).to have_content("Total Revenue after Discounts: $0.00")
    end
  end

  it "has a link next to a item that goes to the show page for each applied discount" do
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

    visit "/merchants/#{merchant_A.id}/invoices/#{invoice_A1.id}"

    within ".invoice-item-0" do
      expect(page).to_not have_link("This item applies for discount: #{discount_A1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B2.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C2.id}")
    end

    visit "/merchants/#{merchant_B.id}/invoices/#{invoice_A1.id}"
    within ".invoice-item-1" do
      expect(page).to_not have_link("This item applies for discount: #{discount_A1.id}")
      expect(page).to have_link("This item applies for discount: #{discount_B1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B2.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C2.id}")
    end

    within ".invoice-item-2" do
      expect(page).to_not have_link("This item applies for discount: #{discount_A1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B1.id}")
      expect(page).to have_link("This item applies for discount: #{discount_B2.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C2.id}")
    end

    visit "/merchants/#{merchant_C.id}/invoices/#{invoice_A1.id}"
    within ".invoice-item-3" do
      expect(page).to_not have_link("This item applies for discount: #{discount_A1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_B2.id}")
      expect(page).to have_link("This item applies for discount: #{discount_C1.id}")
      expect(page).to_not have_link("This item applies for discount: #{discount_C2.id}")
    end
  end
end
