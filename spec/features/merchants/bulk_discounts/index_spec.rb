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

  it 'displays a section titled Upcoming Holidays with the next 3 US holidays' do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 0.1, quantity_threshold: 10)
    upcoming_holidays = PublicHolidaysFacade.find_holidays

    holiday_1 = upcoming_holidays[0]
    holiday_2 = upcoming_holidays[1]
    holiday_3 = upcoming_holidays[2]

    visit "/merchants/#{merchant_1.id}/bulk_discounts"

    within ".upcoming-holidays" do
      expect(page).to have_content("Upcoming Holidays")

      expect(upcoming_holidays.length).to eq(3)
      expect(holiday_1.name).to appear_before(holiday_2.name)
      expect(holiday_2.name).to appear_before(holiday_3.name)
    end
  end
end
