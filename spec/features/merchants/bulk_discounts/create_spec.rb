require 'rails_helper'

RSpec.describe "the merchant bulk discounts create page" do
  it "exists and has a form with expected fields" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")

    within ".new-discount" do
      expect(page).to have_content("Percentage discount")
      expect(page).to have_content("Quantity threshold")
      expect(page).to have_button("Create Bulk discount")
    end
  end

  it "can create a discount with valid data and redirects to index" do
    merchant_1 = Merchant.create!(name: "Staples")
    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

    within ".new-discount" do
      fill_in :bulk_discount_percentage_discount, with: 0.1
      fill_in :bulk_discount_quantity_threshold, with: 10
      click_button "Create Bulk discount"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")

    within ".bulk-discount-0" do
      expect(page).to have_content("Discount %: 0.1")
      expect(page).to have_content("Qty to qualify: 10")
    end
  end

  it "cannot create a discount without a percentage_discount" do
    merchant_1 = Merchant.create!(name: "Staples")
    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

    within ".new-discount" do
      fill_in :bulk_discount_quantity_threshold, with: 10
      click_button "Create Bulk discount"
    end
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
    expect(page).to have_content("Discount not created: Required information missing.")
    expect(page).to have_button("Create Bulk discount")
  end

  it "cannot create a discount without a quantity_threshold" do
    merchant_1 = Merchant.create!(name: "Staples")
    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

    within ".new-discount" do
      fill_in :bulk_discount_percentage_discount, with: 0.1
      click_button "Create Bulk discount"
    end
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
    expect(page).to have_content("Discount not created: Required information missing.")
    expect(page).to have_button("Create Bulk discount")
  end
end
