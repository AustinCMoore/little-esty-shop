require 'rails_helper'
RSpec.describe "the merchant bulk discounts index" do
  it "exists" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit "/merchants/#{merchant_1.id}/bulk_discounts"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
  end

  it 'displays a merchants bulk discounts and their information' do
    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Lowes")

    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    bulk_discount_2 = merchant_2.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 20)
    bulk_discount_3 = merchant_1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 30)

    visit "/merchants/#{merchant_1.id}/bulk_discounts"

    within ".bulk-discount-0" do
      expect(page).to have_link("Discount ID: #{bulk_discount_1.id}")
      expect(page).to have_content("Discount %: #{bulk_discount_1.percentage_discount}")
      expect(page).to have_content("Qty to qualify: #{bulk_discount_1.quantity_threshold}")
    end

    expect(page).to_not have_link("Discount ID: #{bulk_discount_2.id}")
    expect(page).to_not have_content("Discount %: #{bulk_discount_2.percentage_discount}")
    expect(page).to_not have_content("Qty to qualify: #{bulk_discount_2.quantity_threshold}")

    within ".bulk-discount-1" do
      expect(page).to have_link("Discount ID: #{bulk_discount_3.id}")
      expect(page).to have_content("Discount %: #{bulk_discount_3.percentage_discount}")
      expect(page).to have_content("Qty to qualify: #{bulk_discount_3.quantity_threshold}")
    end
  end

  it 'displays a merchants bulk discounts and their information' do
    merchant_1 = Merchant.create!(name: "Staples")
    merchant_2 = Merchant.create!(name: "Lowes")

    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    bulk_discount_2 = merchant_2.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 20)
    bulk_discount_3 = merchant_1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 30)

    visit "/merchants/#{merchant_1.id}/bulk_discounts"

    within ".bulk-discount-0" do
      click_link "Discount ID: #{bulk_discount_1.id}"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}")
  end
end
