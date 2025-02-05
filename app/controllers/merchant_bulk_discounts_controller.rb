class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    next_3_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(discount_params)
    if bulk_discount.save
      redirect_to "/merchants/#{merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new", notice: "Discount not created: Required information missing."
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(discount_params)
    if bulk_discount.save
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount.id}"
    else
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/#{bulk_discount.id}/edit", notice: "Discount not updated: Required information missing."
    end
  end

  private

  def discount_params
    params.require(:bulk_discount).permit(:percentage_discount,
                                          :quantity_threshold)
  end
end
