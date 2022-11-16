class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    # require 'pry'; binding.pry
    @customer = @invoice.customer
    @total_revenue = (@invoice.admin_total_revenue.to_f / 100)
    @invoice_items = @invoice.invoice_items
  end

  def index
    @invoices = Invoice.all
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update!(status: params[:status])
    redirect_to admin_invoice_path(@invoice)
  end 
end
