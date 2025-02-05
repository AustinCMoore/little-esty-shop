require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do

  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:percentage_discount) }
    it { should validate_numericality_of(:percentage_discount).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:percentage_discount).is_less_than_or_equal_to(1) }
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:quantity_threshold).only_integer }
  end
end
