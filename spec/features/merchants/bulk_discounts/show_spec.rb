require 'rails_helper'

RSpec.describe "the merchant bulk discounts show" do
  it "exists" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)

    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}")
  end

  it "has the discount's attributes" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}"

    within ".discount-attributes" do
      expect(page).to have_content("Discount %: #{bulk_discount_1.percentage_discount}")
      expect(page).to have_content("Qty to qualify: #{bulk_discount_1.quantity_threshold}")
    end
  end
end
