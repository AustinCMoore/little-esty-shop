class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.unique_invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_revenue = ((@invoice.total_revenue_by_merchant(params[:merchant_id])).to_f/100).round(2)
    @discounted_revenue = ((@invoice.total_revenue_by_merchant(params[:merchant_id]) - @invoice.total_discounts_by_merchant(params[:merchant_id])).to_f/100).round(2)
  end

  def update
    altered_invoice_item = InvoiceItem.find(params[:invoice_item_id])
    altered_invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:id]}"
  end

end
