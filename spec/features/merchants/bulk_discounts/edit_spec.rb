require 'rails_helper'

RSpec.describe "the merchant bulk discounts edit" do
  it "exists and pre-populates form with attributes" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit")

    within ".discount-form" do
      expect(page).to have_field(:bulk_discount_percentage_discount, with: bulk_discount_1.percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold, with: bulk_discount_1.quantity_threshold)
      expect(page).to have_button('Update Discount')
    end
  end

  it "fills form with valid data and is linked to an updated show page" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"

    within ".discount-form" do
      fill_in :bulk_discount_percentage_discount, with: 0.2
      fill_in :bulk_discount_quantity_threshold, with: 20
      click_button "Update Discount"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}")

    within ".discount-attributes" do
      expect(page).to_not have_content("Discount %: 0.1")
      expect(page).to_not have_content("Qty to qualify: 10")

      expect(page).to have_content("Discount %: 0.2")
      expect(page).to have_content("Qty to qualify: 20")
    end
  end

  it "returns to the edit page if discount % is missing" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"

    within ".discount-form" do
      fill_in :bulk_discount_quantity_threshold, with: 20
      click_button "Update Discount"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit")
    expect(current_path).to have_content("Discount not updated: Required information missing.")

    within ".discount-form" do
      expect(page).to have_field(:bulk_discount_percentage_discount, with: bulk_discount_1.percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold, with: bulk_discount_1.quantity_threshold)
      expect(page).to have_button('Update Discount')
    end
  end

  it "returns to the edit page if qty threshold is missing" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit"

    within ".discount-form" do
      fill_in :bulk_discount_percentage_discount, with: 0.2
      click_button "Update Discount"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_discount_1.id}/edit")
    expect(current_path).to have_content("Discount not updated: Required information missing.")
    
    within ".discount-form" do
      expect(page).to have_field(:bulk_discount_percentage_discount, with: bulk_discount_1.percentage_discount)
      expect(page).to have_field(:bulk_discount_quantity_threshold, with: bulk_discount_1.quantity_threshold)
      expect(page).to have_button('Update Discount')
    end
  end
end
