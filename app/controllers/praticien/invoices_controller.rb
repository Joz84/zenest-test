
class Praticien::InvoicesController < ApplicationController
  def index
    @invoices = policy_scope([:praticien, Invoice])
    authorize([:praticien, Invoice])
    @invoice = Invoice.new
    authorize([:praticien, @invoice])
    render layout: "dashboard"
  end

  def create
    @invoice = current_user.actable.invoices.new(invoice_params)
    authorize ([:praticien, @invoice])
    if @invoice.save
      redirect_to praticien_invoices_path
      flash[:notice] = "Votre facture a été ajoutée avec succés."
    else
      @invoices = policy_scope([:praticien, Invoice])
      render "praticien/invoices/index", layout: "dashboard"
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:title, :pdf, :date, :reference, :amount_cents, :amount, :pdf_cache)
  end
end
