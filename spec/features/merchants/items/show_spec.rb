require 'rails_helper'

RSpec.describe "Merchant Items Show Page" do
  describe 'when I visit this page' do
    it "has the Item listed with all of its attributes" do
      Merchant.destroy_all
      Item.destroy_all
      merchant = Merchant.create!(name: "Paul the Merchant")
      item1 = merchant.items.create!(name: "Paul's Item",
                                     description: "Paul's very popular item",
                                     unit_price: "2500")
      item2 = merchant.items.create!(name: "Paul's Other Item",
                                     description: "Paul's less popular item",
                                     unit_price: "2")
      visit "/merchants/#{merchant.id}/items/#{item1.id}"

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.unit_price)
      expect(page).to_not have_content(item2.name)
    end
  end
end
