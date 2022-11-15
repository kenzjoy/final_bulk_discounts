class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(discount_params)
    @bulk_discount.save 
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy!
    redirect_to merchant_bulk_discounts_path(@merchant.id) 
  end

  private
  def discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end